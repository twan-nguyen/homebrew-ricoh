cask "ricoh-hub" do
  version "0.2.0"
  sha256 "145b0a9ac743acfdb878fc7e100a28a04a74162805bffdc37e5f15b1150a7c79"

  url "https://github.com/twan-nguyen/ricoh-hub/releases/download/v#{version}/Ricoh-Hub-#{version}.zip"
  name "Ricoh Hub"
  desc "Status, printing, scanning and alerts for a Ricoh IM 3500 printer"
  homepage "https://github.com/twan-nguyen/ricoh-hub"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Ricoh Hub.app"

  # Ad-hoc signed and not notarized: clear the download quarantine so Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Ricoh Hub.app"]
  end

  # The login item stays through upgrades, so only zap removes it.
  uninstall quit: "com.ricohhub.desktop"

  zap trash: [
    "~/Library/Application Support/com.ricohhub.desktop",
    "~/Library/Caches/com.ricohhub.desktop",
    "~/Library/LaunchAgents/Ricoh Hub.plist",
    "~/Library/Saved Application State/com.ricohhub.desktop.savedState",
    "~/Library/WebKit/com.ricohhub.desktop",
  ]
end
