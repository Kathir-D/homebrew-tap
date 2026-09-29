# Homebrew tap for Sonar

```sh
brew tap Kathir-D/tap
brew install --cask sonar
```

`Casks/sonar.rb` is published by Sonar's release workflow and is also attached to each
[GitHub release](https://github.com/Kathir-D/Sonar/releases). Updates: `brew upgrade --cask sonar`.

Sonar is ad-hoc signed and not notarized, because it has no paid Apple Developer account.
Homebrew downloads with `curl`, which sets no quarantine attribute, so this install path is
unaffected. Downloading the release zip in a browser may require a one-time manual approval
in System Settings > Privacy & Security.
