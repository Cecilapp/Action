# GitHub Action for Cecil

A GitHub Action to build a static site with [_Cecil_](https://cecil.app) commands.

The following example:
1. runs on pushes to the master branch
2. install theme(s)
3. run `php cecil.phar build -v --baseurl=https://example.com/`
4. deploy `_site` to GitHub Pages

```hcl
workflow "Cecil Action" {
  resolves = [
    "Deploy to GitHub Pages",
  ]
  on = "push"
}

action "Filter master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Composer Install" {
  uses = "pxgamer/composer-action@master"
  args = "install"
}

action "Build Cecil static site" {
  uses = "Cecilapp/Cecil-Action@master"
  needs = [
    "Filter master branch",
    "Composer Install",
  ]
  args = "--baseurl=https://example.com/"
}

action "Deploy to GitHub Pages" {
  uses = "maxheld83/ghpages@v0.2.1"
  needs = "Build Cecil static site"
  env = {
    BUILD_DIR = "_site/"
  }
  secrets = ["GITHUB_TOKEN"]
}
```
