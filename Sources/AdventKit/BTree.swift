import Foundation

/// A simple, non-balancing BTree.
public class BTree<Element: Comparable> {

    /// A Node within the BTree.
    class Node {
        var element: Element
        var left: Node?
        var right: Node?

        init(element: Element, left: Node? = nil, right: Node? = nil) {
            self.element = element
            self.left = left
            self.right = right
        }
    }

    /// The root node.
    var root: Node?

    public init() {
    }

    /// Insert the element into the proper location within the BTree without performing any balancing.
    public func insert(_ element: Element) {
        guard var node = root else {
            root = Node(element: element)
            return
        }

        while true {
            if element < node.element {
                if let left = node.left {
                    node = left
                } else {
                    node.left = Node(element: element)
                    return
                }
            } else {
                if let right = node.right {
                    node = right
                } else {
                    node.right = Node(element: element)
                    return
                }
            }
        }
    }
}

extension BTree: Sequence {
    public struct Iterator: IteratorProtocol {
        private var stack: [Node] = []

        init(_ root: Node?) {
            // Walk down the left hand side of the BTree, creating a stack of nodes. This will
            // get us to the element with the smallest value.
            var current = root
            while let node = current {
                stack.append(node)
                current = node.left
            }
        }

        public mutating func next() -> Element? {
            guard let nextNode = stack.popLast() else { return nil }

            // Collect right subtree
            var current = nextNode.right
            while let node = current {
                stack.append(node)
                current = node.left
            }

            return nextNode.element
        }
    }

    public func makeIterator() -> Iterator {
        return Iterator(root)
    }
}
