public final class Stack<T> {
    public var count: Int { storage.count }
    public var isEmpty: Bool { storage.isEmpty }
    public var top: T? { storage.isEmpty ? nil : storage.last! }

    private var storage: [T] = []

    public init() {}

    public func push(_ value: T) {
        storage.append(value)
    }

    public func pop() -> T? {
        guard storage.count > 0 else { return nil }
        return storage.removeLast()
    }
}
