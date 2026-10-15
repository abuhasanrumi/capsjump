// The names Nightcrawler is known by to macOS and the paths it reads. The bundle
// identifier is what macOS records Accessibility and Automation grants against, so it
// never changes after the first release.

import Foundation

public enum Identity {
    public static let bundleID = "ai.stigmer.nightcrawler"
    public static let scheme = "nightcrawler"
    public static let chromeBundleID = "com.google.Chrome"
}

public enum Paths {
    /// `~/.nightcrawler.yaml`, beside karayaml's `~/.kara.yaml` so both dotfiles travel together.
    public static func config(home: URL = FileManager.default.homeDirectoryForCurrentUser) -> URL {
        home.appendingPathComponent(".nightcrawler.yaml")
    }

    /// Chrome's `Local State`, which maps each profile folder to its account.
    public static func chromeLocalState(home: URL = FileManager.default.homeDirectoryForCurrentUser) -> URL {
        home.appendingPathComponent("Library/Application Support/Google/Chrome/Local State")
    }
}
