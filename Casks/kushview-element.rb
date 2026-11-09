cask "kushview-element" do
  version "1.1.1"
  sha256 "f59c2f22137d36f4bcc6c16b2293904c7d559011c70fdd9a0dda23537989cb03"

  url "https://github.com/kushview/element/releases/download/#{version}/element-#{version}-macos.dmg"
  name "Element"
  desc "Advanced audio plugin host"
  homepage "https://kushview.net/element"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  conflicts_with cask: "element"
  depends_on :macos

  pkg "element-#{version}-macos.pkg"

  uninstall pkgutil: [
    "net.kushview.pkg.ElementApp",
    "net.kushview.pkg.ElementAU",
    "net.kushview.pkg.ElementCLAP",
    "net.kushview.pkg.ElementLV2",
    "net.kushview.pkg.ElementVST2",
    "net.kushview.pkg.ElementVST3",
  ]

  zap trash: [
        "~/Library/Application Support/Kushview/Element",
        "~/Library/Caches/com.juce.locks/juceAppLock_Element",
        "~/Library/Preferences/net.kushview.Element.plist",
      ],
      rmdir: "~/Library/Application Support/Kushview"
end
