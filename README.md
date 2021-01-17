# Cecil build Action

> This Action builds a static site with [_Cecil_](https://cecil.app).

## Usage

```yaml
- name: Build site
  uses: Cecilapp/Cecil-Action@v2
  with:
    version: '5.41.0'     # optional
    args: '-v'            # optional
    install_themes: 'yes' # optional
    install_intl: 'no'    # optional
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

    - name: Build site
      uses: Cecilapp/Cecil-Action@v2

    - name: Deploy site
      uses: Cecilapp/GitHub-Pages-deploy@v3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        email: arnaud@ligny.org
```
