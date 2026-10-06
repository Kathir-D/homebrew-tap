# Homebrew cask for Stockroom, the equipment checkout for a school media
# department. Installs the prebuilt binary from the GitHub release tarball
# (built by GoReleaser, .goreleaser.yaml).
#
# A cask and not a formula. Stockroom ships a single static binary, but it
# installs a LaunchDaemon, asks for a password once during `stockroom setup`,
# and puts a Postgres LaunchDaemon and a config file outside any prefix Homebrew
# owns. A formula would have to own all of that to behave, and this is an
# application with its own setup command, not a library.
#
# A cask and not a plain `binary` install either, because the tarball unpacks
# `deploy/camera/`, which `setup --with-camera` runs out of the directory the
# binary lands in. Keeping the whole tree together in the Caskroom is what
# makes that path work.
#
# NOTE: `version` and the `sha256` values are refreshed by CI
# (.github/workflows/release.yml) on every `v*` tag, which also copies this file
# into the Kathir-D/homebrew-tap tap. Do not hand-edit the version or the
# checksums. The version and `__SHA256_*__` placeholders are what CI
# substitutes; the committed file in the tap has real values.
cask "stockroom" do
  version "0.9.3"

  on_macos do
    on_arm do
      sha256 "6acf9a4df2d4b1966d53722f5cec345c8030f864a467a3ec5a672868a149ad68"
      url "https://github.com/Kathir-D/Stockroom/releases/download/v#{version}/stockroom_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "2d338dac5122369a5b3dd40456c0995c5c422d9e982f5597b0abc30cad2c8208"
      url "https://github.com/Kathir-D/Stockroom/releases/download/v#{version}/stockroom_darwin_amd64.tar.gz"
    end
  end
  # Linux installs through the .deb (scripts/get.sh), which apt pulls
  # PostgreSQL and rclone in for. These blocks let a Linux user who prefers
  # Homebrew install the binary itself and run the same `stockroom setup`;
  # `setup` then uses the distribution's Postgres rather than Homebrew's.
  #
  # No blank line before this comment, and none after the closing `end` below
  # until `name`. `on_macos` and `on_linux` are one stanza group, and
  # Cask/StanzaGrouping wants no lines inside a group and exactly one between
  # groups. Both offenses are the same rule seen from either side.
  on_linux do
    on_arm do
      sha256 "ae2ec9b2288597b13a27209926a069c3ee097c28285d30a6fc0274d554232189"
      url "https://github.com/Kathir-D/Stockroom/releases/download/v#{version}/stockroom_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "57e4fe1452e475c75ffd778aca0b6c1e555f27013b7bea6b6c439a17521253d5"
      url "https://github.com/Kathir-D/Stockroom/releases/download/v#{version}/stockroom_linux_amd64.tar.gz"
    end
  end

  name "stockroom"
  desc "Equipment checkout for a school media department"
  homepage "https://github.com/Kathir-D/Stockroom"

  livecheck do
    url :url
    strategy :github_latest
  end

  # PostgreSQL and rclone, which `stockroom setup` needs and which a cask
  # cannot install from a deb's Depends. The Linux package asks for
  # postgresql >= 14, the oldest version the CI matrix tests; this pins 17
  # because that is the formula Homebrew ships as `postgresql@17`, and the
  # setup wizard's LaunchDaemon is written against Homebrew's layout.
  depends_on formula: [
    "postgresql@17",
    "rclone",
  ]

  # The tarball unpacks `stockroom` at the top level, next to `deploy/` and
  # `docs/`. Only the binary is linked; the rest of the tree stays in the
  # Caskroom, where `setup --with-camera` finds deploy/camera/.
  binary "stockroom"

  # Unsigned, so Homebrew quarantines the download and macOS refuses to run it
  # the first time. Sonar and headless-spotify both needed this for their .app
  # bundles; the same fix applies to a bare binary, and `staged_path` is the
  # copy Homebrew verified against the sha256 above.
  #
  # The rescue matters for the reason the other two explain at length: without
  # it, a Homebrew that dropped `postflight` would make this cask file invalid,
  # and an invalid cask stops the whole tap from loading — `brew tap` would fail
  # and Sonar and headless-spotify would stop installing too. Rescued, the worst
  # case is one Gatekeeper approval by hand.
  #
  # `brew style` reports one offense on the block below, Cask/InstallSteps, and
  # it cannot be resolved: Homebrew requires postflight_steps, whose DSL exposes
  # only if_path_exists, on_macos, version and token and cannot run a command at
  # all; and Style/DisableCopsWithinSourceCodeDirective forbids suppressing the
  # cop. Check the cask with the cop excluded:
  #   brew style --except-cops Cask/InstallSteps kathir-d/tap/stockroom
  begin
    postflight do
      system_command(
        "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "#{staged_path}/stockroom"],
        must_succeed: false,
      )
    end
  rescue NoMethodError
    # Homebrew dropped the postflight block. Nothing to do; the install itself
    # still succeeds, the user approves the binary once themselves.
  end

  caveats <<~EOS
    That was the whole install. One command finishes it:

      stockroom setup

    It creates the database, writes the config, and installs two LaunchDaemons
    so Stockroom and PostgreSQL both start at boot with nobody logged in. It
    asks for your password once, and then opens http://127.0.0.1:8080, where a
    setup wizard takes it from there.

    To add the closet camera later: `stockroom setup --with-camera`.
  EOS
end
