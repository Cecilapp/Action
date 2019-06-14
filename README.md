# GitHub Action for Cecil

An Action to run [_Cecil_](https://cecil.app) commands.

This example :
1. runs on pushes to the master branch
2. will run `php cecil.phar -v --baseurl=https://example.com/`

```
workflow "Cecil build" {
  resolves = [
    "Cecil Action",
  ]
  on = "push"
}

action "Cecil Action" {
  uses = "Cecilapp/Cecil-Action@master"
  needs = "Filter master branch"
  args = "--baseurl=https://example.com/"
}

action "Filter master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}
```
