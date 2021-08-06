public final class Graph {
    public private(set) var count = 0
    private var adjList: [Int: Set<Int>] = [:]

    public func addEdge(from: Int, to: Int) {
        guard
            from != to,
            adjList[from] != nil,
            !adjList[from]!.contains(to) // try to add not existing
        else { return }

        adjList[from]!.insert(to)
    }

    public func addVertex(_ vertex: Int) {
        guard !adjList.keys.contains(vertex) else { return }
        adjList[vertex] = Set()
        count += 1
    }

    public func printGraph() {
        adjList.keys.sorted().forEach { vertex in
            if adjList[vertex]!.isEmpty {
                print(vertex)
                return
            }
            print("\(vertex) ->", terminator: "")
            adjList[vertex]!.sorted().forEach { connected in
                print(" \(connected)", terminator: "")
            }
            print("\n", terminator: "")
        }
    }
}
