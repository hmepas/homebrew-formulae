# homebrew-formulae

Personal [Homebrew](https://brew.sh) tap for [hmepas](https://github.com/hmepas) projects.

> **Note:** for `brew tap hmepas/formulae` to work, this repository must be
> published on GitHub as `hmepas/homebrew-formulae`.

## Install

```bash
brew tap hmepas/formulae
brew install grappa
brew install obi && brew services start obi
```

Or install the latest development version straight from `main`:

```bash
brew install --HEAD hmepas/formulae/grappa
```

## Test a formula locally

Homebrew only installs formulae from a tap, so push first, then:

```bash
brew update && brew install hmepas/formulae/obi
```

## Releasing a new version

1. In the project repo (bump `version` in `pyproject.toml` for grappa), tag and push:

   ```bash
   git tag v0.2.0 && git push origin v0.2.0
   ```

2. In this repo, update the formula and commit:

   ```bash
   scripts/update-formula.sh grappa 0.2.0
   git commit -am "grappa 0.2.0"
   git push
   ```

## Formulae

| Formula | Description |
|---------|-------------|
| `grappa` | Telegram cli |
| `obi` | Native macOS status bar for yabai |
