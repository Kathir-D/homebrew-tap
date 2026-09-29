# Kathir-D's Homebrew tap

```sh
brew tap Kathir-D/tap
brew trust --tap Kathir-D/tap   # Homebrew 7 won't load an untrusted tap
```

| Install | What | Source |
| --- | --- | --- |
| `brew install --cask kathir-d/tap/sonar` | Spotify in your menu bar, with hybrid auto-pause | [Kathir-D/Sonar](https://github.com/Kathir-D/Sonar) |
| `brew install kathir-d/tap/headless-spotify` | Hide Spotify from the Dock and Cmd-Tab, keep AppleScript control | [Kathir-D/headless-spotify](https://github.com/Kathir-D/headless-spotify) |
| `brew install --cask kathir-d/tap/stockroom` | Barcode-driven equipment checkout for a school media department. Arrives with its first release | [Kathir-D/Stockroom](https://github.com/Kathir-D/Stockroom) |

Updates: `brew update && brew upgrade`.

Each project's release workflow commits its own file here (`Casks/sonar.rb`,
`Formula/headless-spotify.rb`, `Casks/stockroom.rb`) using a deploy key that can write to this
repository only. Don't edit those files by hand; change them in the project and release.

## After installing

- **headless-spotify** only puts files in place. The step that edits Spotify is separate:
  `sudo "$(brew --prefix headless-spotify)/install.sh"`. See `brew info headless-spotify`.
- **Stockroom** needs one more command: `stockroom setup`.
- **Sonar** and **Stockroom** are ad-hoc signed and not notarized. Both casks clear the quarantine
  attribute after the checksum is verified, so macOS opens them without the one-time "Open Anyway"
  approval. (`brew install --no-quarantine` no longer exists in Homebrew 7.)
