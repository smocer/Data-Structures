public final class BinarySearchTree<T: Comparable> {
    final class Node<T: Comparable> {
        var value: T
        var left: Node<T>?
        var right: Node<T>?

        init(_ value: T, left: Node<T>? = nil, right: Node<T>? = nil) {
            self.value = value
            self.left = left
            self.right = right
        }

        var isLeaf: Bool { left == nil && right == nil }

        func printSubtree(_ tabLevel: Int = 0) {
            let tabLevel = tabLevel + 1
            let space = "_"
            let firstSymbol = "⎿"
            let tabs = ([firstSymbol] + Array(repeating: space, count: tabLevel - 1)).joined()
            print(value)
            if let l = left {
                print(tabs + "L-", terminator: "")
                l.printSubtree(tabLevel + 1)
            }
            if let r = right {
                print(tabs + "R-", terminator: "")
                r.printSubtree(tabLevel + 1)
            }
        }
    }

    public private(set) var count: Int = 0
    public var isEmpty: Bool { count == 0 }

    private var root: Node<T>?
    private(set) var height: Int = 0 // doesnt work (not accounted when removing node)

    public init() {}

    public func insert(_ value: T) {
        count += 1

        if root == nil { return root = Node<T>(value) }

        var current = root
        height = 1
        while current != nil {
            height += 1
            if value < current!.value {
                if let left = current!.left {
                    current = left
                } else {
                    current!.left = Node<T>(value)
                    return
                }
            } else {
                if let right = current!.right {
                    current = right
                } else {
                    current!.right = Node<T>(value)
                    return
                }
            }
        }
    }

    public func search(_ value: T) -> T? {
        var current = root
        while let cur = current {
            if cur.value == value { return cur.value }
            if value < cur.value {
                current = cur.left
            } else {
                current = cur.right
            }
        }
        return nil
    }

    public func remove(_ value: T) {
        guard root != nil else { return }
        count -= 1

        var parent: Node<T>? = nil
        var current = root

        while current != nil && current?.value != value {
            parent = current
            current = current!.value > value ? current!.left : current!.right
        }

        guard let toRemove = current else {
            return
        }

        if toRemove.isLeaf { // just delete it
            if parent == nil {
                return root = nil
            }

            if toRemove.value < parent!.value {
                parent?.left = nil
            } else {
                parent?.right = nil
            }
            return
        }

        if toRemove.left == nil {
            return set(toRemove.right!, toParent: parent)
        }

        if toRemove.right == nil {
            return set(toRemove.left!, toParent: parent)
        }


        // if has left AND right
        if toRemove.right!.left == nil {
            set(toRemove.right!, toParent: parent)
            toRemove.right!.left = toRemove.left
        } else {
            let minVal = findAndDeleteMin(toRemove.right!)
            let replacementNode = Node<T>(minVal)
            set(replacementNode, toParent: parent)
            replacementNode.left = toRemove.left
            replacementNode.right = toRemove.right
        }
    }

    private func set(_ node: Node<T>, toParent parent: Node<T>?) {
        guard let parent = parent else {
            return root = node
        }

        if node.value < parent.value {
            parent.left = node
        } else {
            parent.right = node
        }
    }

    private func findAndDeleteMin(_ subtree: Node<T>) -> T {
        var parent = subtree
        guard var current = parent.left else { fatalError("ti axyel") }

        while let left = current.left {
            parent = current
            current = left
        }

        parent.left = current.right
        return current.value
    }

    public func easyPrint() {
        if let root = root {
            root.printSubtree(1)
        } else {
            print("nil")
        }
    }

    public func breadthFirstSearch() -> [T] {
        guard let root = root else { return [] }

        var list: [T] = []
        let queue = Queue<Node<T>>()
        queue.enqueue(root)

        while let current = queue.dequeue() {
            list.append(current.value)
            current.left.map {
                queue.enqueue($0)
            }
            current.right.map {
                queue.enqueue($0)
            }
        }

        return list
    }

    public func DFSInOrder() -> [T] {
        traverseInOrder(node: root, list: [])
    }

    public func DFSPreOrder() -> [T] {
        traversePreOrder(node: root, list: [])
    }

    public func DFSPostOrder() -> [T] {
        traversePostOrder(node: root, list: [])
    }

    private func traverseInOrder(node: Node<T>?, list: [T]) -> [T] {
        guard let node = node else { return list }
        var list = list
        if let left = node.left {
            list = traverseInOrder(node: left, list: list)
        }
        list += [node.value]
        if let right = node.right {
            list = traverseInOrder(node: right, list: list)
        }
        return list
    }

    private func traversePreOrder(node: Node<T>?, list: [T]) -> [T] {
        guard let node = node else { return list }
        var list = list
        list += [node.value]
        if let left = node.left {
            list = traversePreOrder(node: left, list: list)
        }
        if let right = node.right {
            list = traversePreOrder(node: right, list: list)
        }
        return list
    }

    private func traversePostOrder(node: Node<T>?, list: [T]) -> [T] {
        guard let node = node else { return list }
        var list = list
        if let left = node.left {
            list = traversePostOrder(node: left, list: list)
        }
        if let right = node.right {
            list = traversePostOrder(node: right, list: list)
        }
        list += [node.value]
        return list
    }
}
