@testable import EmojiKit
import XCTest

final class EmojiKitTests: XCTestCase {
    func testEmojisCanBeAccessed() {
        XCTAssertFalse(EmojiKit.allEmojis.isEmpty)
    }

    static var allTests = [
        ("testEmojisCanBeAccessed", testEmojisCanBeAccessed)
    ]
}
