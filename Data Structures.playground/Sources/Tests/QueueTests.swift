import XCTest

public class QueueTests: XCTestCase {
    var queue: Queue!

    public override func setUp() {
        queue = Queue()
    }

    public func testQueueCount() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { queue.enqueue($0) }
        XCTAssertEqual(testInput.count, queue.count)
    }

    public func testEnqueueOrderFirstElement() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { queue.enqueue($0) }
        XCTAssertEqual(queue.first, testInput.first)
    }

    public func testEnqueueOrderLastElement() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { queue.enqueue($0) }

        var last: Int?
        while !queue.isEmpty {
            last = queue.dequeue()
        }

        XCTAssertEqual(last, testInput.last)
    }

    public func testEmptyQueue() {
        XCTAssertTrue(queue.isEmpty)
    }

    public func testNonEmptyQueue() {
        let testInput = [1, 2, 3, 4, 5]
        testInput.forEach { queue.enqueue($0) }
        XCTAssertTrue(!queue.isEmpty)
    }
}
