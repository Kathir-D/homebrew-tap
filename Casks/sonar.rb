cask "sonar" do
  version "0.1.1"
  sha256 "654eca1cd535966d860c999834dfdf22cb72b8164fa78afc5f54b5d7b4ffdc1a"

  url "https://github.com/Kathir-D/Sonar/releases/download/v#{version}/Sonar-#{version}.zip"
  name "Sonar"
  desc "Spotify in your macOS menu bar, with hybrid auto-pause"
  homepage "https://github.com/Kathir-D/Sonar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Sonar.app"

  uninstall quit: "com.KathirD.sonar"

  zap trash: [
    "~/Library/Application Scripts/com.KathirD.sonar",
    "~/Library/Caches/com.KathirD.sonar",
    "~/Library/Containers/com.KathirD.sonar",
    "~/Library/HTTPStorages/com.KathirD.sonar",
    "~/Library/Logs/Sonar",
    "~/Library/Preferences/com.KathirD.sonar.plist",
  ]
end
