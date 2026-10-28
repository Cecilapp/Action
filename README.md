# Cecil build Action

This GitHub Action builds a [_Cecil_](https://cecil.app) site and uploads a GitHub Pages artifact.

[![test](https://github.com/Cecilapp/Action/actions/workflows/test.yml/badge.svg)](https://github.com/Cecilapp/Action/actions/workflows/test.yml)

## Usage

```yaml
- name: Build site
  uses: Cecilapp/Action@v4
  # optional
  with:
    path: docs                       # default: "." (repository root)
    version: 9.25.0                  # default: latest version
    php_version: "8.4"               # default: "8.3"
    install_themes: "yes"            # default: "yes"
    options: -v --config=config.yml  # default: "-v" (verbose)
    pages: "true"                    # default: "true"
    cache: "true"                    # default: "true"
```

### Inputs

| Name             | Description                                                                                   | Default  |
| ---------------- | --------------------------------------------------------------------------------------------- | -------- |
| `path`           | Path to the site source directory, relative to the repository root.                           | `.`      |
| `version`        | Cecil version (e.g. `9.25.0`).                                                                | latest   |
| `php_version`    | PHP version (Cecil requires PHP 8.3+ since version 9).                                        | `8.3`    |
| `install_themes` | Set to `no` to skip installing theme(s) with Composer (when a `composer.json` file exists).   | `yes`    |
| `options`        | Cecil `build` command options. `--baseurl` is set to the GitHub Pages URL unless provided.    | `-v`     |
| `pages`          | Set to `false` to skip GitHub Pages setup and artifact upload (e.g. to deploy elsewhere).     | `true`   |
| `cache`          | Set to `false` to disable Cecil (`.cache`) and Composer cache.                                | `true`   |

> [!NOTE]
> If the output directory is changed in the configuration file, also set it with the `--output` option so the Action can find it.

### Outputs

| Name            | Description                              |
| --------------- | ---------------------------------------- |
| `output_dir`    | Path to the generated site directory.    |
| `cecil_version` | Version of Cecil used to build the site. |

### Workflow example

The following workflow:

1. runs on pushes to the `main` and `master` branches
2. checkout source
3. setup PHP
4. downloads Cecil
5. installs theme(s)
6. configures GitHub Pages
7. runs Cecil build
8. upload pages artifact
9. deploys to GitHub Pages

```yaml
name: Build and deploy to GitHub Pages
on:
  push:
    branches: [main, master]
  workflow_dispatch:
concurrency:
  group: pages
  cancel-in-progress: true
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout source
        uses: actions/checkout@v7
      - name: Build site
        uses: Cecilapp/Action@v4
  deploy:
    needs: build
    permissions:
      pages: write
      id-token: write
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v5
```

> [!TIP]
> The Action must be preceded by `actions/checkout`. If your theme is a Git submodule (e.g. in `themes/<name>`), fetch it with `submodules: true`:
>
> ```yaml
> - name: Checkout source
>   uses: actions/checkout@v7
>   with:
>     submodules: true
> ```

### Without GitHub Pages

```yaml
- name: Build site
  id: cecil
  uses: Cecilapp/Action@v4
  with:
    pages: false
    options: -v --baseurl=https://example.com/
- name: Deploy
  run: ./deploy.sh "${{ steps.cecil.outputs.output_dir }}"
```

## License

_Cecil build Action_ is a free software distributed under the terms of the MIT license.

© [Arnaud Ligny](https://arnaudligny.fr)
