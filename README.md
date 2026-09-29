# Kathir-D's Homebrew tap

```sh
brew tap Kathir-D/tap
```

| Project | Install | What it does |
| --- | --- | --- |
| [Sonar](https://github.com/Kathir-D/Sonar) | `brew install --cask kathir-d/tap/sonar` | Spotify in your menu bar, pausing when something else makes noise |
| [headless-spotify](https://github.com/Kathir-D/headless-spotify) | `brew install kathir-d/tap/headless-spotify` | Hides Spotify from the Dock and Cmd-Tab, made to pair with Sonar |
| [Stockroom](https://github.com/Kathir-D/Stockroom) | `brew install --cask kathir-d/tap/stockroom` | Barcode equipment checkout for a school media department. Arrives with its first release |

## Updates

```sh
brew update && brew outdated                            # check
brew update && brew upgrade --cask kathir-d/tap/sonar   # upgrade
```

`brew update` first — it refreshes the tap, and that's the only way Homebrew learns a new version
exists. Nothing here updates itself.

## Trust

Homebrew 7 won't load a cask from a tap it doesn't trust, but you needn't tell it about this one:
every command above names its tap, and `brew install` trusts a cask or formula named with its tap
before resolving it. `brew trust --tap Kathir-D/tap` is only for short names like
`brew install --cask sonar`, which identify nothing.

## After installing

- **Sonar** and **stockroom** are ad-hoc signed and not notarized. Both casks clear the quarantine
  flag after Homebrew verifies the SHA-256, so macOS won't ask you to approve them.
- **headless-spotify** only places files. To make it edit Spotify:
  `sudo "$(brew --prefix headless-spotify)/install.sh"`.
- **stockroom** is a server, not an app. Run `stockroom setup` after installing; it asks for your
  password once, to write two LaunchDaemons. It also runs on Debian and Ubuntu — see
  [the install guide](https://github.com/Kathir-D/Stockroom/blob/main/docs/INSTALL.md).

## For maintainers

Each release workflow owns one file here — `Casks/sonar.rb`, `Formula/headless-spotify.rb`,
`Casks/stockroom.rb` — through a deploy key scoped to this repository. Change the project and
release; don't hand-edit these.
