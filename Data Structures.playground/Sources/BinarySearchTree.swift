public final class BinarySearchTree {
    final class Node {
        var value: Int
        var left: Node?
        var right: Node?

        init(_ value: Int, left: Node? = nil, right: Node? = nil) {
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

    private var root: Node?
    private(set) var height: Int = 0 // doesnt work (not accounted when removing node)

    public init() {}

    public func insert(_ value: Int) {
        count += 1

        if root == nil { return root = Node(value) }

        var current = root
        height = 1
        while current != nil {
            height += 1
            if value < current!.value {
                if let left = current!.left {
                    current = left
                } else {
                    current!.left = Node(value)
                    return
                }
            } else {
                if let right = current!.right {
                    current = right
                } else {
                    current!.right = Node(value)
                    return
                }
            }
        }
    }

    public func search(_ value: Int) -> Int? {
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

    public func remove(_ value: Int) {
        guard root != nil else { return }
        count -= 1

        var parent: Node? = nil
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
            let replacementNode = Node(minVal)
            set(replacementNode, toParent: parent)
            replacementNode.left = toRemove.left
            replacementNode.right = toRemove.right
        }
    }

    private func set(_ node: Node, toParent parent: Node?) {
        guard let parent = parent else {
            return root = node
        }

        if node.value < parent.value {
            parent.left = node
        } else {
            parent.right = node
        }
    }

    private func findAndDeleteMin(_ subtree: Node) -> Int {
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
}
