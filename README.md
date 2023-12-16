# Cecil build Action

This GitHub Action builds a static site with [_Cecil_](https://cecil.app).

## Usage

```yaml
- name: Build site
  uses: Cecilapp/Cecil-Action@v3
  # optional
  with:
    version: '8.0.0'      # default: latest version
    config: 'config.yml'  # default: ''
    args: '-v'            # default: '-v'
    install_themes: 'yes' # default: 'yes'
```

### Workflow example

The following workflow:

1. runs on pushes to the `master` branch
2. checkout source
3. setup PHP
4. downloads Cecil
5. installs theme(s)
6. runs `php cecil.phar build -v`
7. deploys `_site` to GitHub Pages

```yaml
name: Build and deploy to GitHub Pages
on:
  push:
    branches: [main] # or [master]
  workflow_dispatch: # run manually

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
        uses: actions/checkout@v4

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.1'
          extensions: fileinfo, gd, mbstring

      - name: Build site
        uses: Cecilapp/Cecil-Action@v3

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2

  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v3
```

## License

_Cecil build Action_ is a free software distributed under the terms of the MIT license.

© [Arnaud Ligny](https://arnaudligny.fr)
