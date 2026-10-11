cask "vidneat" do
  # `version` and `sha256` are rewritten by scripts/update-cask.sh as the last
  # step of a release. They describe the notarized universal archive attached to
  # the GitHub release; the all-zero checksum below is a placeholder that makes
  # an install fail loudly until a release has been published.
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/ravi923615/vidneatdowndesktop/releases/download/v#{version}/VidNeat-#{version}-universal.zip"
  name "VidNeat"
  desc "Video and audio downloader"
  homepage "https://github.com/ravi923615/vidneatdowndesktop"

  # The app's own Sparkle feed is the source of truth for the latest version.
  livecheck do
    url "https://ravi923615.github.io/homebrew-vidneat/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so `brew upgrade` leaves it alone.
  auto_updates true
  depends_on macos: ">= :ventura"

  app "VidNeat.app"

  zap trash: [
    "~/Library/Application Support/VidNeat",
    "~/Library/Caches/com.vidneat.desktop",
    "~/Library/HTTPStorages/com.vidneat.desktop",
    "~/Library/Preferences/com.vidneat.desktop.plist",
    "~/Library/Saved Application State/com.vidneat.desktop.savedState",
  ]
end
