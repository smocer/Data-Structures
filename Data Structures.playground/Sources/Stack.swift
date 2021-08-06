public final class Stack {
    public var count: Int { storage.count }
    public var isEmpty: Bool { storage.isEmpty }
    public var top: Int? { storage.isEmpty ? nil : storage.last! }

    private var storage: [Int] = []

    public init() {}

    public func push(_ value: Int) {
        storage.append(value)
    }

    public func pop() -> Int? {
        guard storage.count > 0 else { return nil }
        return storage.removeLast()
    }
}
