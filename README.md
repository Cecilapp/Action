# Cecil build Action

This GitHub Action builds a [_Cecil_](https://cecil.app) site and uploads a GitHub Pages artifact.

[![test](https://github.com/Cecilapp/Action/actions/workflows/test.yml/badge.svg)](https://github.com/Cecilapp/Action/actions/workflows/test.yml)

## Usage

```yaml
- name: Build site
  uses: Cecilapp/Cecil-Action@v4
  # optional
  with:
    version: 8.0.0                   # default: latest version
    options: -v --config=config.yml  # default: "-v" (verbose)
    install_themes: yes              # default: "yes"
```

### Workflow example

The following workflow:

1. runs on pushes to the `main` and `master` branches
2. checkout source
3. setup PHP
4. downloads Cecil
5. installs theme(s)
6. runs Cecil to build the site
7. upload artifact
8. deploys `_site` to GitHub Pages

```yaml
name: Build and deploy to GitHub Pages
on:
  push:
    branches: [main, master]
  workflow_dispatch:
permissions:
  contents: read
  pages: write
  id-token: write
concurrency:
  group: "pages"
  cancel-in-progress: true
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout source
        uses: actions/checkout@v6
      - name: Build site
        uses: Cecilapp/Cecil-Action@v4
  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v5
```

## License

_Cecil build Action_ is a free software distributed under the terms of the MIT license.

© [Arnaud Ligny](https://arnaudligny.fr)
