QueueTests.defaultTestSuite.run()
StackTests.defaultTestSuite.run()

let tree = BinarySearchTree<Int>()
//[14, 9, 15, 6, 12, 17, 5, 7, 10, 16, 18]
[9, 4, 1, 6, 20, 15, 170].forEach { tree.insert($0) }
tree.easyPrint()
print(tree.breadthFirstSearch())
print(tree.DFSInOrder())
print(tree.DFSPreOrder())
print(tree.DFSPostOrder())
