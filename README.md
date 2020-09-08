# EmojiKit
EmojiKit is a simple emoji-querying framework in Swift.

Installation
------------
Please use the Swift Package Manger to integrate this framework into your project.

For Carthage and CocoaPods you must use an older version of this framework.

Usage
-----
##### 1. Create an EmojiFetcher instance variable.

```swift
let fetcher = EmojiFetcher()
```

##### 2. Use EmojiFetcher's `query` function to get an array of `Emoji` structs that match the given search string.

```swift
fetcher.query("food") { emojiResults in
  for emoji in emojiResults {
    print("Current Emoji: \(emoji.character) \(emoji.name)")
  }
}
```

Where does emoji.json come from?
------------

Please have a look at [gemoji](https://github.com/github/gemoji/blob/master/db/emoji.json). 
