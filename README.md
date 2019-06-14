# GitHub Action for Cecil

An Action to run [_Cecil_](https://cecil.app) commands.

This example :
1. runs on pushes to the master branch
2. will run `php cecil.phar --baseurl=https://example.com/`

```
workflow "Cecil Action" {
  resolves = [
    "Build static site",
  ]
  on = "push"
}

action "Build static site" {
  uses = "Cecilapp/Cecil-Action@master"
  needs = [
    "Filter master branch",
    "Composer Install",
  ]
  args = "--baseurl=https://example.com/"
}

action "Filter master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Composer Install" {
  uses = "pxgamer/composer-action@master"
  args = "install"
}
```
