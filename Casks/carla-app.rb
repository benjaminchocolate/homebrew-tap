# typed: strict
# frozen_string_literal: true

cask "carla-app" do
  version "2.5.10"
  sha256 "a30e98409974493ade18f598566628369fee67f179a84e1c2cc3ae46a71808b1"

  url "https://github.com/falkTX/Carla/releases/download/v#{version}/Carla-#{version}-macOS-universal.dmg"
  name "Carla"
  desc "Audio plugin host"
  homepage "https://kx.studio/carla"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Carla.app"
  app "Carla-Control.app"
  pkg "Carla-Plugins.pkg"

  uninstall pkgutil: [
    "studio.kx.carla.lv2",
    "studio.kx.carla.vst2fx",
    "studio.kx.carla.vst2syn",
  ]

  zap trash: [
    "~/Library/Preferences/com.falktx.Carla2.plist",
    "~/Library/Preferences/com.falktx.CarlaDatabase2.plist",
    "~/Library/Preferences/com.falktx.CarlaPlugins5.plist",
      ]

postflight do
    ["Carla.app", "Carla-Control.app"].each do |app|
      path = "#{appdir}/#{app}"
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", path]
      system_command "/usr/bin/codesign",
                     args: ["--force", "--deep", "--sign", "-", path]
    end
end
end
