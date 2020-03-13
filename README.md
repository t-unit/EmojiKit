# EmojiKit
EmojiKit is a simple emoji-querying framework in Swift.

Installation
------------
If you’re using [Carthage](http://github.com/Carthage/Carthage), add EmojiKit to your `Cartfile`:

```swift
github "t-unit/EmojiKit"
```

Otherwise, if you're using [CocoaPods](http://cocoapods.org), add EmojiKit to your `Podfile`:

```ruby
pod 'EmojiKit', :git => 'https://github.com/t-unit/EmojiKit.git'
```

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
