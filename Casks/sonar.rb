cask "sonar" do
  version "0.1.2"
  sha256 "991a8adbc64f7c7298c842014339d56e9545b59eb4d2a58a04881ac44c4706fd"

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

  # Sonar is ad-hoc signed and not notarized, so Gatekeeper would otherwise make
  # every user approve it by hand in System Settings on first launch.
  #
  # Homebrew used to offer --no-quarantine for this, but it was removed in 7.x
  # ("Error: invalid option: --no-quarantine") and there is no cask DSL
  # replacement: `postflight_steps` exposes only if_path_exists / on_macos /
  # version / token, and cannot run a command at all. The deprecated
  # `postflight` block can, and still runs.
  #
  # The rescue matters. Without it, removing `postflight` would not merely stop
  # the quarantine from being cleared - it would make the cask file invalid, and
  # an invalid cask stops the whole tap from loading, so `brew tap` would fail
  # and nobody could install anything. Rescued, the worst case is that users get
  # the normal one-time Gatekeeper approval again.
  #
  # The ordering is what makes this reasonable rather than reckless: Homebrew
  # verifies the SHA-256 above before any of this runs, so the checksum is the
  # integrity gate and the quarantine attribute is no longer what stands between
  # the user and an app they knowingly installed from this tap.
  # rubocop:disable Cask/InstallSteps
  # `brew style` asks for postflight_steps, which cannot do this job: that DSL
  # exposes only if_path_exists, on_macos, version and token, and has no way to
  # run a command. The older postflight block can, and still executes. Suppressing
  # the cop here rather than leaving style failing, with the reason recorded.
  begin
    postflight do
      system_command(
        "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "/Applications/Sonar.app"],
        must_succeed: false
      )
    end
  rescue NoMethodError
    # Homebrew dropped the postflight block. Nothing to do; the install itself
    # still succeeds.
  end
  # rubocop:enable Cask/InstallSteps

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
