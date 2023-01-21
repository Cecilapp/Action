# Cecil build Action

This Action builds a static site with [_Cecil_](https://cecil.app).

## Usage

```yaml
- name: Build site
  uses: Cecilapp/Cecil-Action@v3
  with:
    version: '7.0.0'      # optional, default last version
    config: 'config.yml'  # optional, default ''
    args: '-v'            # optional, default '-v'
    install_themes: 'yes' # optional, default 'yes'
```

### Workflow example

The following example:

1. runs on pushes to the `master` branch
2. checkout source
3. downloads Cecil
4. installs theme(s)
5. runs `php cecil.phar build -v`
6. deploys `_site` to GitHub Pages

```yaml
name: Build and deploy to GitHub Pages
on:
  push:
    branches:
      - master

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
        uses: actions/checkout@v3

      - name: Build site
        uses: Cecilapp/Cecil-Action@v3

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v1

  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v1
```

## License

_Cecil build Action_ is a free software distributed under the terms of the MIT license.

© [Arnaud Ligny](https://arnaudligny.fr)
