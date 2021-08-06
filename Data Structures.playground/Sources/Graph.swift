public final class Graph<T: Hashable & Comparable> { // Comparable for sorting keys for printing, consider removing
    public private(set) var numberOfVertices = 0
    private var adjList: [T: Set<T>] = [:]

    public func addEdge(from: T, to: T) {
        guard
            from != to,
            adjList[from] != nil,
            !adjList[from]!.contains(to) // try to add not existing
        else { return }

        adjList[from]!.insert(to)
    }

    public func addVertex(_ vertex: T) {
        guard !adjList.keys.contains(vertex) else { return }
        adjList[vertex] = Set()
        numberOfVertices += 1
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
