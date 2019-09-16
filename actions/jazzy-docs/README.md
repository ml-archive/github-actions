### Jazzy docs Github Action
A github action for swift projects. Uses the Jazzy documentation framework to autogenerate docs in html

#### Usage
You have to create a .yml file in the `.github/workflows/`
eg.: `.github/workflows/release.yml`

```yml
on: release # the event that triggers the action, more information here 👉 https://help.github.com/en/articles/events-that-trigger-workflows
name: Auto docs # the name of the action
jobs:
  jazzyDocs:
    name: Jazzy docs
    runs-on: ubuntu-18.04
    steps:
      - uses: actions/checkout@master
      - name: Generate docs
        uses: nodes-vapor/github-actions/actions/jazzy-docs@develop
        with:
          target: Submissions # the target for which you want to build the documentation
          commit_msg: Update Jazzy docs # the commit message
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SOURCEKITTEN_REVISION: 0.24.0
          JAZZY_VERSION: 0.10.0
```
