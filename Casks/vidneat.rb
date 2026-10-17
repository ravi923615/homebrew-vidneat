cask "vidneat" do
  # `version` and `sha256` are rewritten by scripts/update-cask.sh as the last
  # step of a release. They describe the universal DMG attached to the release
  # on this tap's own (public) repository; the all-zero checksum below is a
  # placeholder that makes an install fail loudly until a release is published.
  version "1.0.2"
  sha256 "0ba5f8832e6629ab90aaa81dafd2d507ce2f12ef2eba053d2888326ab9a451fd"

  url "https://github.com/ravi923615/homebrew-vidneat/releases/download/v#{version}/VidNeat-#{version}-universal.dmg"
  name "VidNeat"
  desc "Native video downloader and clip manager"
  homepage "https://vidneat.app/"

  # The app's own Sparkle feed is the source of truth for the latest version.
  livecheck do
    url "https://download.vidneat.app/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so `brew upgrade` leaves it alone.
  auto_updates true
  depends_on macos: ">= :sonoma"

  app "VidNeat.app"

  # VidNeat is distributed only through this tap and is ad-hoc signed (no
  # Apple Developer ID). Homebrew marks downloads as quarantined, which would
  # make Gatekeeper refuse to open an ad-hoc signed app; clear the flag on the
  # installed copy, and only on it, so the app opens normally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/VidNeat.app"]
  end

  zap trash: [
    "~/Library/Application Support/VidNeat",
    "~/Library/Caches/com.vidneat.desktop",
    "~/Library/HTTPStorages/com.vidneat.desktop",
    "~/Library/Preferences/com.vidneat.desktop.plist",
    "~/Library/Saved Application State/com.vidneat.desktop.savedState",
  ]
end
