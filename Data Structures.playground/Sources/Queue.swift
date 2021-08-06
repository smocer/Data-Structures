public final class Queue {
    private final class Node {
        var value: Int
        var next: Node?

        init(_ value: Int) {
            self.value = value
        }
    }

    private(set) var count: Int = 0
    public var isEmpty: Bool { count == 0 }
    public var first: Int? { head?.value }

    private var head: Node?
    private var tail: Node?

    public init() {}

    public func enqueue(_ value: Int) {
        count += 1
        guard head != nil else {
            head = Node(value)
            tail = head
            return
        }

        let newNode = Node(value)
        tail!.next = newNode
        tail = newNode
    }

    public func dequeue() -> Int? {
        guard let head = head else { return nil }
        count -= 1
        let retVal = head.value
        self.head = head.next
        return retVal
    }
}
