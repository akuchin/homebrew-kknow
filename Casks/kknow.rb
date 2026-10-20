cask "kknow" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "c4c8a820d8c1bf08553aeaa026ffdcf4a767b98cd7bff83b29f2f6f3f710e091",
         intel: "a8f6e832e4c8531bc15dc3a341086e0daa5cef740dddc4122d832bd8dae3da76"

  url "https://github.com/akuchin/kknow/releases/download/v#{version}/kknow_#{version}_#{arch}.dmg"
  name "kknow"
  desc "Local-first knowledge base for Markdown files"
  homepage "https://github.com/akuchin/kknow"

  livecheck do
    url :url
    strategy :github_latest
  end

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
