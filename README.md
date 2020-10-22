# locust-action
GitHub Action for the [Locust diff tool](https://github.com/simiotics/locust).

## Using this action

The easiest way is to add the following YAML as `.github/workflows/locust.yml` in your GitHub
repositories:

```yaml
name: Locust summary

on: [ pull_request_target ]

jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
      - name: PR head repo
        id: head_repo_name
        run: |
          HEAD_REPO_NAME=$(jq -r '.pull_request.head.repo.full_name' "$GITHUB_EVENT_PATH")
          echo "PR head repo: $HEAD_REPO_NAME"
          echo "::set-output name=repo::$HEAD_REPO_NAME"
      - name: Checkout git repo
        uses: actions/checkout@v2
        with:
          repository: ${{ steps.head_repo_name.outputs.repo }}
          fetch-depth: 0
      - name: Generate Locust summary
        uses: simiotics/locust-action@main
        id: locust
        with:
          format: html-github
      - name: Comment on PR
        uses: actions/github-script@v3
        with:
          script: |
            github.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '${{ steps.locust.outputs.summary }}',
            })
```

### fetch-depth

Note the `fetch-depth: 0` in the `actions/checkout@v2` step.

This is a very important parameter. Without it, the full git history will not be available to Locust.


### pull_request_target vs. pull_request

The sample above uses the `pull_request_target` event to trigger the GitHub Action as actions
triggered on `pull_request` events from forks do not have permissions to write comments to pull
requests in the base repo.

See GitHub's announcement about `pull_request_target` for more information:
https://github.blog/2020-08-03-github-actions-improvements-for-fork-and-pull-request-workflows/#improvements-for-public-repository-forks
