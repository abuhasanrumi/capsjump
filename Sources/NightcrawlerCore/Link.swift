// What a nightcrawler:// link asks for: a site by name, or one of the app's own actions,
// whose names start with `_` so no site can shadow them.

import Foundation

public enum Link: Sendable, Equatable {
    case site(String)
    case setup

    public enum ParseError: Error, Equatable, CustomStringConvertible {
        case notNightcrawler(String)
        case noSite(String)
        case unknownAction(String)

        public var description: String {
            switch self {
            case let .notNightcrawler(link): "`\(link)` is not a \(Identity.scheme):// link"
            case let .noSite(link): "`\(link)` names no site; write \(Identity.scheme)://<site>"
            case let .unknownAction(action): "`\(action)` is not a Nightcrawler action"
            }
        }
    }

    /// `nightcrawler://github`, with or without a trailing slash, is the site `github`.
    public static func parse(_ url: URL) throws(ParseError) -> Link {
        guard url.scheme?.lowercased() == Identity.scheme else {
            throw .notNightcrawler(url.absoluteString)
        }
        let host = (url.host ?? "").lowercased()
        guard !host.isEmpty else { throw .noSite(url.absoluteString) }
        if host.hasPrefix("_") {
            guard host == "_setup" else { throw .unknownAction(host) }
            return .setup
        }
        return .site(host)
    }

    public static func url(forSite name: String) -> URL? {
        URL(string: "\(Identity.scheme)://\(name)")
    }

    public static let setupURL = URL(string: "\(Identity.scheme)://_setup")!
}
