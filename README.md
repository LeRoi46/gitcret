# gitCret
Prevents pushing sensitive keys/credentials. Continuously scan your repositories, commits or pull-requests for sensitive credentials and generate alerts.

# Setup

## New Workflow

- Add following code to the .github/workflows/gitcret.yml
```
name: gitCret

on: [pull_request, push]

jobs:
  gitcret:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        fetch-depth: '0'
    - name: gitCret
      uses: CySeq/gitcret@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
- Your code will be automatically audited for sensitive credentials on each PR and Commit.

## Existing Workflow

- Add following code as a new Job inside your workflow.
```
  gitcret:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        fetch-depth: '0'
    - name: gitCret
      uses: CySeq/gitcret@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Environment Variables
- GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

## Credits
- [zricethezav/gitleaks](https://github.com/zricethezav/gitleaks) for underlying git credentials detection mechanism.
