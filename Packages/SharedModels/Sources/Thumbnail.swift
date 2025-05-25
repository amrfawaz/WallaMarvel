import Foundation

public struct Thumbnail: Decodable, Hashable, Sendable {
    public let path: String
    public let `extension`: String
}
