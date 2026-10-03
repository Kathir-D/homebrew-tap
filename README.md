# Kathir-D's Homebrew tap

```sh
brew tap Kathir-D/tap
```

| Project | Install | Uninstall | What it does |
| --- | --- | --- | --- |
| [Sonar](https://github.com/Kathir-D/Sonar) | `brew install --cask kathir-d/tap/sonar` | `brew uninstall --cask kathir-d/tap/sonar` | Spotify in your menu bar, pausing when something else makes noise |
| [headless-spotify](https://github.com/Kathir-D/headless-spotify) | `brew install --cask kathir-d/tap/headless-spotify` | `brew uninstall --cask kathir-d/tap/headless-spotify` | Hides Spotify from the Dock and Cmd-Tab, made to pair with Sonar |
| [Trak](https://github.com/Kathir-D/Trak) | `brew install kathir-d/tap/trak` | `brew uninstall kathir-d/tap/trak` | A terminal UI and CLI for Spotify on macOS: now playing, album art or a visualizer, synced lyrics |
| [Stockroom](https://github.com/Kathir-D/Stockroom) | `brew install --cask kathir-d/tap/stockroom` | `brew uninstall --cask kathir-d/tap/stockroom` | Barcode equipment checkout for a school media department |

## Updates

```sh
brew update && brew outdated                                # check
brew upgrade --cask kathir-d/tap/sonar       
brew upgrade --cask kathir-d/tap/headless-spotify
brew upgrade --cask kathir-d/tap/stockroom
brew upgrade kathir-d/tap/trak               
```

`brew update` first — it refreshes the tap, and that's the only way Homebrew learns a new version
exists. Nothing here updates itself.

## Trust

Homebrew 7 won't load a cask from a tap it doesn't trust, but you needn't tell it about this one:
every command above names its tap, and `brew install` trusts a cask or formula named with its tap
before resolving it. `brew trust --tap Kathir-D/tap` is only for short names like
`brew install --cask sonar`, which identify nothing.

## After installing

- **Sonar**, **headless-spotify** and **stockroom** are all casks, so `--cask` is part of the
  command, not an optional extra. All three are ad-hoc signed and not notarized, and all three clear
  the quarantine flag after Homebrew verifies the SHA-256, so macOS won't ask you to approve them.
- **Trak** it installs one command, `trak`. Type `trak` for the TUI, `trak status` for a one-liner.
  It is a universal binary, ad-hoc signed and not notarized, and Homebrew's download is not quarantined,
  so macOS shows no prompt. The first command that talks to Spotify asks your terminal for Automation
  permission, once.
- **headless-spotify** installs the app: `brew install --cask` puts a menu bar extra in
  `/Applications/headless-spotify.app` and starts it, so the icon is in your top bar before you run
  anything else. It does not touch Spotify.
- **headless-spotify** hiding Spotify is a separate, deliberate step, because it edits a root-owned
  signed bundle — the one thing here that needs `sudo`:
  `sudo /Applications/headless-spotify.app/Contents/Resources/install.sh`.
  To undo it, run the same path with `uninstall.sh` **before** `brew uninstall --cask`, because the
  cask is what carries the script:
  `sudo /Applications/headless-spotify.app/Contents/Resources/uninstall.sh`.
  Heads up: on Spotify ≥1.3.1 hiding does not take effect at all (the app quits whenever
  `LSUIElement` is set), so that command reports the failure, rolls your `Info.plist` back, leaves
  Spotify running normally and skips its watcher daemon. Nothing is left broken, and the menu bar
  icon, `status` and `restore` keep working either way. See
  [Current status](https://github.com/Kathir-D/headless-spotify#current-status).
- **stockroom** is a server, not an app. Run `stockroom setup` after installing; it asks for your
  password once, to write two LaunchDaemons. It also runs on Debian and Ubuntu — see
  [the install guide](https://github.com/Kathir-D/Stockroom/blob/main/docs/INSTALL.md).
  Upgrading over a working install keeps the database: the server dumps it with `pg_dump` before
  applying a migration, and refuses to migrate rather than change the schema without a copy.
  `stockroom doctor` reports the state of PostgreSQL, rclone, the config and the service.

## For maintainers

Each release workflow owns one file here — `Casks/sonar.rb`, `Casks/headless-spotify.rb`,
`Casks/stockroom.rb`, `Formula/trak.rb` — through a deploy key scoped to this repository. Change the project and
release; don't hand-edit these.

Each of those casks is written and commented by hand, and its `version` and `sha256` are
refreshed from that project's release. The rest of this file is edited by hand.
