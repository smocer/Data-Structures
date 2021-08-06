import XCTest

public class StackTests: XCTestCase {
    var stack: Stack!

    public override func setUp() {
        stack = Stack()
    }

    public func testStackCount() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { stack.push($0) }
        XCTAssertEqual(testInput.count, stack.count)
    }

    public func testEnqueueOrderFirstElement() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { stack.push($0) }
        XCTAssertEqual(stack.top, testInput.last)
    }

    public func testEnqueueOrderLastElement() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { stack.push($0) }

        var last: Int?
        while !stack.isEmpty {
            last = stack.pop()
        }

        XCTAssertEqual(last, testInput.first)
    }

    public func testEmptyStack() {
        XCTAssertTrue(stack.isEmpty)
    }

    public func testNonEmptyStack() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { stack.push($0) }
        XCTAssertTrue(!stack.isEmpty)
    }
}
