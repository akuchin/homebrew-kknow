# homebrew-kknow

This is the [Homebrew](https://brew.sh) tap for
[kknow](https://github.com/akuchin/kknow), a local-first knowledge base for
plain Markdown files.

The source code, the documentation and the issues are in the main repository:
<https://github.com/akuchin/kknow>.

## Install

```bash
brew install --cask akuchin/kknow/kknow
```

The command adds this tap and installs `kknow.app` into `/Applications`.

## Update

```bash
brew upgrade --cask kknow
```

## Remove

```bash
brew uninstall --cask kknow
```

To also remove the settings and caches of the app, add `--zap`. Your vaults
stay unchanged, because they are ordinary folders with `.md` files.

## About Gatekeeper

The app is not signed with an Apple Developer ID. Thus macOS puts it in
quarantine, and the first launch fails with the message "app is damaged". The
cask removes the quarantine attribute after the installation, so you do not
have to do it.

If you install the app from the `.dmg` file without Homebrew, remove the
attribute yourself:

```bash
xattr -dr com.apple.quarantine /Applications/kknow.app
```

## Release a new version

The cask downloads the `.dmg` file for the Mac architecture from the
[releases of kknow](https://github.com/akuchin/kknow/releases). The release
workflow of kknow makes these files. The names must be
`kknow_<version>_aarch64.dmg` (Apple Silicon) and `kknow_<version>_x64.dmg`
(Intel), and the tag must be `v<version>`.

After a new release, update `version` and the two `sha256` values in
[`Casks/kknow.rb`](Casks/kknow.rb). GitHub shows the digest of each file:

```bash
gh api repos/akuchin/kknow/releases/latest --jq '.assets[] | select(.name | endswith(".dmg")) | "\(.name) \(.digest)"'
```

Then make sure that the cask is correct:

```bash
brew style Casks/kknow.rb
```

```bash
brew audit --cask akuchin/kknow/kknow
```
