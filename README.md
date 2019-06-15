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
    "Build with Cecil and deploy to GitHub Pages",
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

action "Write CNAME" {
  uses = "actions/bin/sh@master"
  needs = "Build Cecil static site"
  args = ["echo \"narno.com\" > _site/CNAME"]
}

action "Build with Cecil and deploy to GitHub Pages" {
  uses = "maxheld83/ghpages@v0.2.1"
  needs = "Write CNAME"
  env = {
    BUILD_DIR = "_site/"
  }
  secrets = ["GITHUB_TOKEN"]
}
```
