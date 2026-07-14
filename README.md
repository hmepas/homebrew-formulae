# homebrew-formulae

Personal [Homebrew](https://brew.sh) tap for [hmepas](https://github.com/hmepas) projects.

> **Note:** for `brew tap hmepas/formulae` to work, this repository must be
> published on GitHub as `hmepas/homebrew-formulae`.

## Install

```bash
brew tap hmepas/formulae
brew install grappa
```

Or install the latest development version straight from `main`:

```bash
brew install --HEAD hmepas/formulae/grappa
```

## Test a formula locally (without tapping)

```bash
brew install --formula ./Formula/grappa.rb
```

## Releasing a new grappa version

1. In the `grappa` repo: bump `version` in `pyproject.toml`, then tag and push:

   ```bash
   git tag v0.2.0 && git push origin v0.2.0
   ```

2. In this repo, update the formula and commit:

   ```bash
   scripts/update-formula.sh 0.2.0
   git commit -am "grappa 0.2.0"
   git push
   ```

## Formulae

| Formula | Description |
|---------|-------------|
| `grappa` | Telegram cli |
