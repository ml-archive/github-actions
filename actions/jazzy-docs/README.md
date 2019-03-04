### Jazzy docs Github Action
A github action for swift projects. Uses the Jazzy documentation framework to autogenerate docs in html

#### Usage
`.github/main.workflow`
Replace the placeholder `[INSERT MODULE NAME HERE]` with the name of the module you need docs for
```
workflow "Auto docs" {
  on = "release"
  resolves = ["Jazzy docs"]
}

action "Jazzy docs" {
  uses = "nodes-vapor/github-actions/actions/jazzy-docs@master"
  secrets = [
    "GITHUB_TOKEN",
    "GH_USER",
    "GH_EMAIL",
  ]
  env = {
    TARGET = "[INSERT MODULE NAME HERE]"
  }
}
```
