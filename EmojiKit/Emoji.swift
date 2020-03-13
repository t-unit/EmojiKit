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

    let aliases: [String]
    let groups: [String]
    let iosVersion: String

    public var id: String {
        // There will never be more that 1 emoji struct for a given character,
        // so we can use the character itself to represent the unique ID
        return character
    }
}

extension Emoji: DictionaryDeserializable {

    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["description"] as? String,
            let character = dictionary["emoji"] as? String,
            let aliases = dictionary["aliases"] as? [String],
            let groups = dictionary["tags"] as? [String],
            let iosVersion = dictionary["ios_version"] as? String else { return nil }

        self.name = name
        self.character = character
        self.aliases = aliases
        self.groups = groups
        self.iosVersion = iosVersion
    }
}

extension Emoji: Equatable {

    public static func ==(lhs: Emoji, rhs: Emoji) -> Bool {
        return lhs.id == rhs.id
    }
}


extension Emoji: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
