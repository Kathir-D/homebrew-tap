# Kathir-D's Homebrew tap

```sh
brew tap Kathir-D/tap
```

| Install | What | Source |
| --- | --- | --- |
| `brew install --cask kathir-d/tap/sonar` | Spotify in your menu bar, with hybrid auto-pause | [Kathir-D/Sonar](https://github.com/Kathir-D/Sonar) |
| `brew install kathir-d/tap/headless-spotify` | Hide Spotify from the Dock and Cmd-Tab, keep AppleScript control | [Kathir-D/headless-spotify](https://github.com/Kathir-D/headless-spotify) |
| `brew install --cask kathir-d/tap/stockroom` | Barcode-driven equipment checkout for a school media department. Arrives with its first release | [Kathir-D/Stockroom](https://github.com/Kathir-D/Stockroom) |

**No `brew trust` needed.** Every command in that table names its tap, and that is what does the
trusting: `brew install` trusts a cask or formula named with its tap before it resolves it. Verified
on Homebrew 7.0.7 with the tap untrusted — `brew install --cask kathir-d/tap/sonar` installed and
added `kathir-d/tap/sonar` to `~/.homebrew/trust.json` on its own.

You only need `brew trust --tap Kathir-D/tap` if you prefer the short names after tapping, where
`brew install --cask sonar` has nothing in the command to identify the tap with. Homebrew 7 refuses
to load anything from an untrusted tap, and that is the error the short form gets you.

Updates: `brew update && brew upgrade`. Name the package to be explicit — `brew upgrade --cask
kathir-d/tap/sonar` — and `brew update` first, because it refreshes the tap and that is the only way
Homebrew learns a new version exists. `brew outdated` lists them without changing anything.

Each project's release workflow commits its own file here (`Casks/sonar.rb`,
`Formula/headless-spotify.rb`, `Casks/stockroom.rb`) using a deploy key that can write to this
repository only. Don't edit those files by hand; change them in the project and release.

## After installing

- **headless-spotify** only puts files in place. The step that edits Spotify is separate:
  `sudo "$(brew --prefix headless-spotify)/install.sh"`. See `brew info headless-spotify`.
- **Stockroom** needs one more command: `stockroom setup`. Run it as yourself, not with `sudo`; it
  asks for your password once, because it writes the two LaunchDaemons that start Stockroom and
  PostgreSQL at boot with nobody logged in. [docs/INSTALL.md](https://github.com/Kathir-D/Stockroom/blob/main/docs/INSTALL.md)
  covers it. Stockroom is a school equipment checkout system, so it also installs on Debian and
  Ubuntu with `curl … get.sh | sudo bash` — see the
  [README](https://github.com/Kathir-D/Stockroom#install). The cask arrives with its first release.
- **Sonar** and **Stockroom** are ad-hoc signed and not notarized. Both casks clear the quarantine
  attribute after the checksum is verified, so macOS opens them without the one-time "Open Anyway"
  approval. (`brew install --no-quarantine` no longer exists in Homebrew 7.)
