//
//  Emoji.swift
//  EmojiKit
//
//  Created by Dasmer Singh on 12/20/15.
//  Copyright © 2015 Dastronics Inc. All rights reserved.
//

public struct Emoji: Identifiable {
    public let name: String
    public let character: String
    public let category: String

    let aliases: [String]
    let groups: [String]
    let iosVersion: String

    public var id: String {
        // There will never be more that 1 emoji struct for a given character,
        // so we can use the character itself to represent the unique ID
        return character
    }
}

extension Emoji: Codable {
    private enum CodingKeys: String, CodingKey {
        case name = "description"
        case character = "emoji"
        case category = "category"
        case aliases = "aliases"
        case groups = "tags"
        case iosVersion = "ios_version"
    }
}

extension Emoji: Equatable {
    public static func ==(lhs: Emoji, rhs: Emoji) -> Bool {
        lhs.id == rhs.id
    }
}

extension Emoji: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
