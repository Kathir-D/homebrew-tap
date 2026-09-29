# Homebrew tap for Sonar

```sh
brew tap Kathir-D/tap
brew install --cask sonar
```

`Casks/sonar.rb` is published by Sonar's release workflow and is also attached to each
[GitHub release](https://github.com/Kathir-D/Sonar/releases). Updates: `brew upgrade --cask sonar`.

Sonar is ad-hoc signed and not notarized, because it has no paid Apple Developer account, so
macOS will ask you to approve it once on first launch: System Settings > Privacy & Security >
Open Anyway. This applies to `brew install --cask` too - Homebrew sets the quarantine attribute
on cask downloads on purpose. To skip the prompt:

    brew install --no-quarantine --cask sonar
