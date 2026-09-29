cask "sonar" do
  version "0.1.0"
  sha256 "f0c177e9c82fdbc0b2cc8f0c46c238aa36a0ba5929f6750cfb7cd199b65f39f6"

  url "https://github.com/Kathir-D/Sonar/releases/download/v#{version}/Sonar-#{version}.zip"
  name "Sonar"
  desc "Spotify in your macOS menu bar, with hybrid auto-pause"
  homepage "https://github.com/Kathir-D/Sonar"

  depends_on macos: ">= :sequoia"
  conflicts_with cask: "spotmenu"

  app "Sonar.app"

  zap trash: [
    "~/Library/Caches/com.KathirD.sonar",
    "~/Library/Containers/com.KathirD.sonar",
    "~/Library/Logs/Sonar",
    "~/Library/Preferences/com.KathirD.sonar.plist",
  ]
end
