public final class Queue<T> {
    private final class Node {
        var value: T
        var next: Node?

        init(_ value: T) {
            self.value = value
        }
    }

    private(set) var count: Int = 0
    public var isEmpty: Bool { count == 0 }
    public var first: T? { head?.value }

    private var head: Node?
    private var tail: Node?

    public init() {}

    public func enqueue(_ value: T) {
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

    public func dequeue() -> T? {
        guard let head = head else { return nil }
        count -= 1
        let retVal = head.value
        self.head = head.next
        return retVal
    }
}
