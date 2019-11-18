# Build a Cecil static site

A GitHub Action to build a static site with [_Cecil_](https://cecil.app) commands.

The following example:
1. runs on pushes to the master branch
2. install theme(s)
3. download Cecil 4.21.2
3. run `php cecil.phar build -v`
4. deploy `_site` to GitHub Pages

```yml
name: Build and deploy
on:
  push:
    branches:
      - master
jobs:
  checkout-build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@master
    - name: Composer Install
      uses: pxgamer/composer-action@master
      with:
        command: install
    - name: Build with Cecil
      uses: Cecilapp/Cecil-Action@V2
      env:
        CECIL_VERSION: '4.21.2'
    - name: Deploy to GitHub Pages
      uses: Cecilapp/GitHub-Pages-deploy@master
      env:
        EMAIL: arnaud@ligny.org               # must be a verified email
        GH_TOKEN: ${{ secrets.ACCESS_TOKEN }} # https://github.com/settings/tokens
        BUILD_DIR: _site/                     # "_site/" by default
```
