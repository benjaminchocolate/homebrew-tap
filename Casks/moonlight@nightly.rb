cask "moonlight@nightly" do
  version "4113dd"
  sha256 "beb7f5b5228436422c8e9cbe3c41071dfe10d3c4763682b8c0d7807d923d4fcd"

  url "https://nightly.link/moonlight-stream/moonlight-qt/workflows/build/master/Moonlight-macOS-#{version}.zip"
  name "Moonlight"
  desc "GameStream client"
  homepage "https://moonlight-stream.org/"

  livecheck do
    url "https://nightly.link/moonlight-stream/moonlight-qt/workflows/build/master"
    regex(/Moonlight-macOS-(\h+)/i)
  end

  conflicts_with cask: "moonlight"
  depends_on :macos
  container nested: "Moonlight-#{version}.dmg"

  app "Moonlight.app"
  binary "#{appdir}/Moonlight.app/Contents/MacOS/Moonlight", target: "moonlight"

  zap trash: [
    "~/Library/Caches/Moonlight Game Streaming Project",
    "~/Library/Preferences/com.moonlight-stream.Moonlight.plist",
    "~/Library/Saved Application State/com.moonlight-stream.Moonlight.savedState",
  ]
end
