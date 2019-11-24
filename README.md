# Hugo for GitHub Pages

Builds and deploys Hugo-generated websites to GitHub Pages

## Inputs

### `hugo_version`

**Required** Version of Hugo to use. Default `"0.59.1"`. See https://github.com/gohugoio/hugo/releases

### `build_folder`

**Required** Folder in which hugo generates the website. Default `"public".

### `build_branch`

**Required** Branch in which the website is published. Default `"master".

### `github_token`

**Required** Token to use to deploy the new version. `${{ github.token }}` or a
[personal access token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
if you need to [clone submodules](https://github.com/actions/checkout#checkout-private-submodules)
(and be sure that the submodule is configured via `https` and not `ssh`).

## Outputs

None.

## Example usage

```yaml
# .github/workflows/deploy.yml
name: Deploy
  push:
    branches: ['master']


jobs:
  hugo_deploy:
    name: Hugo
    runs-on: ubuntu-18.04

    steps:
      - uses: actions/checkout@v1
        with:
          depth: 1
          submodules: true
          token: ${{ secrets.GITHUB_PERSONAL_ACCESS_TOKEN }}

      - uses: K-Phoen/hugo-gh-pages-action@master
        with:
          github_token: ${{ secrets.GITHUB_PERSONAL_ACCESS_TOKEN }}

```

## License

This library is under the [MIT](LICENSE.md) license.
