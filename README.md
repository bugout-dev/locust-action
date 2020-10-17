# locust-action
GitHub Action for the [Locust diff tool](https://github.com/simiotics/locust).

## Using this action

The easiest way is to add the following YAML as `.github/workflows/locust.yml` in your GitHub
repositories:
```
name: Locust summary

on: [pull_request]

jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
      - name: Checkout git repo
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Generate Locust summary
        uses: simiotics/locust-action@v1
        id: locust
        with:
          format: yaml
```

*Note the `fetch-depth: 0` in the `actions/checkout@v2` step. That is a very important parameter.
Without it, the full git history will not be available to Locust.*
