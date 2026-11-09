cask "motu-m-series-updater" do
  version "2026.2,3013"
  sha256 "24a0f2413760ec937b6bac882b40265dc09de1e63ac238d64f37e9206600e33c"

  url "https://motu.com/en-us/download-center/download/#{version.csv.second}"
  name "MOTU M-Series Updater"
  desc "Firmware updater for M2, M4 and M6"
  homepage "https://motu.com/en-us/download/product/408/"

  depends_on :macos

  app "MOTU M-Series Updater (February 2026).app", target: "MOTU M-Series Updater.app"

  zap :not_required
end
