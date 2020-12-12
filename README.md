# Build a Cecil static site

> This builds a static site with [_Cecil_](https://cecil.app).

## Usage

```yaml
    steps:
    - name: Build site
      uses: Cecilapp/Cecil-Action@2.0.0
      env:
        CECIL_VERSION: '5.40.0' # optional
```

### Workflow example

The following example:

1. runs on pushes to the master branch
2. install theme(s)
3. download Cecil
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
      uses: actions/checkout@v2

    - name: Install theme(s)
      run: composer install --prefer-dist --no-dev --no-progress

    - name: Build site
      uses: Cecilapp/Cecil-Action@2.0.0

    - name: Deploy site
      uses: Cecilapp/GitHub-Pages-deploy@3.0.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        email: arnaud@ligny.org
```
