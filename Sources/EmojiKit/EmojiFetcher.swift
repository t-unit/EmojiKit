//
//  Fetcher.swift
//  EmojiKit
//
//  Created by Dasmer Singh on 12/20/15.
//  Copyright © 2015 Dastronics Inc. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
#endif

public let allEmojis: [Emoji] = {
    guard let path = Bundle(for: EmojiFetchOperation.self).path(forResource: "emoji", ofType: "json") else {
        print("Could not find `emoji.json`")
        return []
    }

    guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        print("Failed to load data of `emoji.json`")
        return []
    }

    do {
        let emojis = try JSONDecoder().decode([Emoji].self, from: data)

        #if os(iOS)
            let iosVersion = UIDevice.current.systemVersion
            return emojis.filter { iosVersion.compare($0.iosVersion, options: .numeric) != .orderedAscending }
        #else
            return emojis
        #endif

    } catch {
        print("Failed to decode `emoji.json` with error: \(error)")
        return []
    }
}()

public let emojiCategories: [String] = {
    Array(Set(allEmojis.map { $0.category }))
}()

public let emojisByCategory: [String: [Emoji]] = {
    Dictionary(grouping: allEmojis, by: { $0.category })
}()

private let allEmojisDictionary: [String: Emoji]  = {
    var dictionary = Dictionary<String, Emoji>(minimumCapacity:allEmojis.count)
    allEmojis.forEach {
        dictionary[$0.character] = $0
    }
    return dictionary
}()

public struct EmojiFetcher {

    // MARK: - Properties

    private let backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()


    // MARK: - Initializers

    public init() {}

    // MARK: - Functions

    public func query(_ searchString: String, completion: @escaping (([Emoji]) -> Void)) {
        cancelFetches()

        let operation = EmojiFetchOperation(searchString: searchString)

        operation.completionBlock = {
            guard !operation.isCancelled else { return }

            DispatchQueue.main.async {
                completion(operation.results)
            }
        }

        backgroundQueue.addOperation(operation)
    }

    public func emojis(for category: String) -> [Emoji] {
        allEmojis.filter { $0.category == category }
    }

    public func cancelFetches() {
        backgroundQueue.cancelAllOperations()
    }

    public func isEmojiRepresentedByString(_ string: String) -> Bool {
        return allEmojisDictionary[string] != nil
    }
}

private final class EmojiFetchOperation: Operation {

    // MARK: - Properties

    let searchString: String
    var results: [Emoji] = []


    // MARK: - Initializers

    init(searchString: String) {
        self.searchString = searchString
    }


    // MARK: - NSOperation

    override func main() {
        if let emoji = allEmojisDictionary[searchString] {
            // If searchString is an emoji, return emoji as the result
            results = [emoji]
        } else {
            // Otherwise, search emoji list for all emoji whose name, aliases or groups match searchString.
            results = resultsForSearchString(searchString)
        }
    }


    // MARK: - Functions

    private func resultsForSearchString(_ searchString: String) -> [Emoji] {
        guard !isCancelled else { return [] }

        var results = [Emoji]()

        // Matches in name
        results += allEmojis.filter { $0.name.range(of: searchString, options: .caseInsensitive) != nil }
        guard !isCancelled else { return [] }

        // Alias matches
        results += allEmojis.filter { emoji in
            guard results.firstIndex(of: emoji) == nil else { return false }

            var validResult = false

            for alias in emoji.aliases {
                if alias.range(of: searchString, options: .caseInsensitive) != nil {
                    validResult = true
                    break
                }
            }

            return validResult
        }
        guard !isCancelled else { return [] }

        // Group matches
        results += allEmojis.filter { emoji in
            guard results.firstIndex(of: emoji) == nil else { return false }

            var validResult = false

            for group in emoji.groups {
                if group.range(of: searchString, options: .caseInsensitive) != nil {
                    validResult = true
                    break
                }
            }

            return validResult
        }
        guard !isCancelled else { return [] }

        return results
    }
}
