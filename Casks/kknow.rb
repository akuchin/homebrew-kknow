cask "kknow" do
  version "0.1.3"
  sha256 "4bd754b23068727cb6ac9645c4a775aeed73b91ae3ba98d171d3a79ad123e7a0"

  url "https://github.com/akuchin/kknow/releases/download/v#{version}/kknow_#{version}_aarch64.dmg"
  name "kknow"
  desc "Local-first knowledge base for Markdown files"
  homepage "https://github.com/akuchin/kknow"

  livecheck do
    url :url
    strategy :github_latest
  end

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
