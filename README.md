# GitHub Action for Cecil

A GitHub Action to build a static site with [_Cecil_](https://cecil.app) commands.

The following example:
1. runs on pushes to the master branch
2. install theme(s)
3. run `php cecil.phar build -v --baseurl=https://narno.com/`
4. deploy `_site` to GitHub Pages

```hcl
workflow "Build and deploy" {
  resolves = [
    "Deploy to GH Pages",
  ]
  on = "push"
}

action "Filter master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Install theme(s)" {
  uses = "pxgamer/composer-action@master"
  args = "install"
}

action "Build Cecil static site" {
  uses = "Cecilapp/Cecil-Action@master"
  needs = [
    "Filter master branch",
    "Install theme(s)",
  ]
  args = "--baseurl=https://narno.com/"
}

action "Deploy to GH Pages" {
  uses = "Cecilapp/GHPages-deploy-Action@master"
  needs = "Build Cecil static site"
  env = {
    BUILD_DIR = "_site/"
    CNAME = "narno.com"
    EMAIL = "arnaud+github@ligny.fr"
  }
  secrets = ["GH_TOKEN"]
}
```
