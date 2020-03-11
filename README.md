# Build a Cecil static site

A GitHub Action to build a static site with [_Cecil_](https://cecil.app).

## Usage

```yaml
- name: Build site with Cecil
  uses: Cecilapp/Cecil-Action@2.0.0
  env:
    CECIL_VERSION: '5.14.4' # optional
```

### Example

The following example:
1. runs on pushes to the master branch
2. install theme(s)
3. download Cecil 5.14.4
3. run `php cecil.phar build -v`
4. deploy `_site` to GitHub Pages

```yaml
name: Build and deploy
on:
  push:
    branches:
      - master
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout source
      uses: actions/checkout@v1
    - name: Install themes(s)
      uses: pxgamer/composer-action@v2.1.0
      with:
        command: install
    - name: Build site with Cecil
      uses: Cecilapp/Cecil-Action@2.0.0
      env:
        CECIL_VERSION: '5.14.4'
    - name: Deploy site to GitHub Pages
      uses: Cecilapp/GitHub-Pages-deploy@2.0.1
      env:
        EMAIL: arnaud@ligny.org
        GH_TOKEN: ${{ secrets.ACCESS_TOKEN }}
        BUILD_DIR: _site
```
