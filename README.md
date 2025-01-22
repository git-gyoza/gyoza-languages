<p align="center">
  <img src="https://img.shields.io/gem/v/gyoza-languages?color=aa0000" alt="">
  <img src="https://img.shields.io/github/actions/workflow/status/git-gyoza/gyoza-languages/gem-push.yml?label=tests" alt="">
</p>

**gyoza-languages** is a simple interface that combines the 
speed of [GitHub Linguist](https://github.com/github-linguist/linguist)
with the highly efficient Ruby web server [Puma](https://github.com/puma/puma).

It allows to query an **HTTP Rest API** to retrieve the languages data from one
or many repositories in a **JSON** format.

| Table of Contents |
|-------------------|
| [Usage](#usage)   |
| [API](#api)       |

# Usage 

The application requires only a few arguments, but they are essential 
for its correct functioning.

```
A Ruby implementation of the Github linguist project with an integrated simple HTTP web server.

Usage: gyoza-languages [options]

    -p, --port PORT                 Starts the server with the specified port (2015 by default).
    -d, --directory DIRECTORY       Manually specifies the repositories directory.
    -h, --help                      Show this message

If the -d argument is not specified, a REPOSITORIES_DIRECTORY environment variable will be necessary.
```

Specifying a port is optional as the default value is `2015`.

The most important (and mandatory) parameter is the `--directory`:
this represents the directory where all the repositories are stored.
Defining a correct directory is crucial for **managing** the web server **endpoints**.

You can set one by either creating an **environment variable** with name
**REPOSITORIES_DIRECTORY** or by directly specifying it using **--directory** (or **-d**).

Let's assume that the folder structure you choose looks like this:

```python
repositories_directory:
    images:
        # a bunch of images
    gyoza-languages:
        # a clone of this repository
    my_repositories:
        super_awesome_repo:
            # another Git repository 
```

This means that all the directories in the folder will become endpoints,
but only a few will be valid:

- `/images` will answer with **404 Not Found**, as it is not a **valid repository**;
- `/gyoza-languages` is a valid repository and will return the correct answer;
- `/my_repositories` is **NOT** a valid repository, even though it contains other repositories.
  As such, it will answer with **404 Not Found**;
- `/my_repositories/super_awesome_repo` is a valid repository.

Along with that, the query parameter `branch` is also available,
meaning that it is possible to obtain the languages count from another branch.
An example is: `/myrepositories/super_awesome_repo?branch=dev` (if not existing, a **404 Not found**
message will be returned).

# API

**gyoza-languages** also provides an **API** for general purposes and one to interact with
the server started by the application itself.

After importing the module using `require 'gyoza-languages'`, two core classes are available:

- [GyozaApp](../main/lib/gyoza-languages/gyoza_app.rb).
  This class offers five different methods that correspond to the **HTTP request methods**:
  
  - `get(path, query, env)`;
  - `post(path, query, env)`;
  - `put(path, query, env)`;
  - `patch(path, query, env)`;
  - `delete(path, query, env)`.
  
  By overriding these methods, it is possible to implement custom responses for each one
  of the requests. The arguments passed are:

  - `path`: the corresponding path in a string format;
  - `query`: a hash that corresponds to the queried parameters;
  - `env`: a hash comprehending all the current environment variables and more data.
  
  If the **HTTP method** is not among the listed above, by overriding the `call(env)`
  function it is possible to access directly to the core responding function, and
  retrieve the method with `env[REQUEST_METHOD]`;

- [GyozaLanguageApp](../main/lib/gyoza-languages/gyoza_language_app.rb).
  This class is the heart of the application. It extends
  [GyozaApp](../main/lib/gyoza-languages/gyoza_app.rb) to provide support for
  [GitHub Linguist](https://github.com/github-linguist/linguist) when a 
  **GET request** is done to the server.
