cask "kknow" do
  version "0.4.2"
  sha256 "fbc5681ce6962a0b16af765203f03dab089565bf06be3c7a370f94ed76f20874"

  url "https://github.com/akuchin/kknow/releases/download/v#{version}/kknow_#{version}_aarch64.dmg"
  name "kknow"
  desc "Local-first knowledge base for Markdown files"
  homepage "https://github.com/akuchin/kknow"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself (Settings → General). Thus `brew upgrade` skips it,
  # as for Zed and Sublime, and does not fight the app over the version.
  # `brew upgrade --greedy` still updates it.
  auto_updates true
  # The kknow releases have no build for Intel Macs.
  depends_on arch: :arm64
  depends_on :macos

  app "kknow.app"

  # The app is not signed with an Apple Developer ID. Without this step,
  # Gatekeeper blocks the first launch and tells that the app is damaged.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/kknow.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.kknow.desktop",
    "~/Library/Caches/dev.kknow.desktop",
    "~/Library/Preferences/dev.kknow.desktop.plist",
    "~/Library/Saved Application State/dev.kknow.desktop.savedState",
    "~/Library/WebKit/dev.kknow.desktop",
  ]
end
