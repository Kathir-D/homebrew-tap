cask "sonar" do
  version "0.1.1"
  sha256 "654eca1cd535966d860c999834dfdf22cb72b8164fa78afc5f54b5d7b4ffdc1a"

  url "https://github.com/Kathir-D/Sonar/releases/download/v#{version}/Sonar-#{version}.zip"
  name "Sonar"
  desc "Spotify in your menu bar, with hybrid auto-pause"
  homepage "https://github.com/Kathir-D/Sonar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Sonar.app"

  # Sonar is ad-hoc signed and not notarized, so Gatekeeper would otherwise
  # make every user approve it by hand in System Settings on first launch.
  # Homebrew's --no-quarantine flag, which used to be the way to avoid this, was
  # removed in Homebrew 7 ("Error: invalid option: --no-quarantine"), and there
  # is no cask DSL for it.
  #
  # So do it here, after Homebrew has already verified the SHA-256 above. That
  # ordering is what makes this reasonable rather than reckless: the archive was
  # checksum-verified before this runs, so the quarantine attribute is no longer
  # the thing standing between the user and an app they knowingly installed from
  # this tap.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "/Applications/Sonar.app"],
                   must_succeed: false
  end

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
