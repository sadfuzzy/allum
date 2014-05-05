# Allum

**A Rack app for local wiki**

## What's Allum?

Allum is actually an authentication layer for [gollum](https://github.com/gollum/gollum) Precious::App.
Gollum is a local wiki source, based on GIT repository.

## Features

- You can define write permissions for each user
- Text filters (Markdown, Textile, ...)

### Start

1. In config.ru you can set some params:
  * gollum_path - path to wiki repository, defaults to *./wikidata*
  * authorized_users - users information file path, defaults to *users.yml*
  * default_markup - defaults to *markdown*
  * wiki_options - no description in gollum readme, but gets hash of options like: base_path, pages directory, js enable, and others

2. Run bundle:
    ```sh
    $ bundle install
    ```

3. Add users with:
    ```sh
    $ rake 'add_user[John Doe, some@email.com, secret, true]'
    ```

4. Start the server with:
    ```sh
    $ ./serve.sh
   ```

5. Enjoy :)
