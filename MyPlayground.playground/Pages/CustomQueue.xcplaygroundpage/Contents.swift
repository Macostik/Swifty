protocol QueueType {
    typealias Element
    mutating func enqueue(element: Element)
    mutating func dequeue() -> Element?
    func peek() -> Element?
}

final class Storage<Element> {
    
    private var pointer: UnsafeMutablePointer<Element>
    private let capacity: Int
    
    init(capacity: Int) {
        pointer = UnsafeMutablePointer<Element>.alloc(capacity)
        self.capacity = capacity
    }
    
    static func copy(storage: Storage) -> Storage<Element> {
        let storageNew = Storage<Element>(capacity: storage.capacity)
        storageNew.pointer.initializeFrom(storage.pointer, count: storage.capacity)
        return storageNew
    }
    
    func add(element: Element, at index: Int) {
        (pointer + index).initialize(element)
    }
    
    func removeAt(index: Int) {
        (pointer + index).destroy()
    }
    
    func itemAt(index: Int) -> Element {
        return (pointer + index).memory
    }
    
    deinit {
        pointer.destroy(capacity)
        pointer.dealloc(capacity)
    }
    
}

struct Queue<Element> : QueueType {
    
    private var storage: Storage<Element>
    private var rear: Int = 0
    private var front: Int = 0
    private var count: Int = 0
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
        storage = Storage<Element>(capacity: capacity)
    }
    
    private mutating func makeUnique() {
        if !isUniquelyReferencedNonObjC(&storage) {
            storage = Storage.copy(storage)
        }
    }
    
    mutating func enqueue(element: Element) {
        guard count < capacity else {
            print("Queue is full.")
            return
        }
        makeUnique()
        storage.add(element, at: rear)
        rear = (rear + 1) % capacity
        count = count + 1
    }
    
    mutating func dequeue() -> Element? {
        guard count > 0 else {
            print("Queue is empty.")
            return nil
        }
        
        makeUnique()
        let item = storage.itemAt(front)
        storage.removeAt(front)
        front = (front + 1) % capacity
        count = count - 1
        return item
    }
    
    func peek() -> Element? {
        guard count > 0 else {
            print("Queue is empty.")
            return nil
        }
        return storage.itemAt(front)
    }
    
}

extension Queue : CustomStringConvertible {
    internal var description: String {
        guard count > 0 else {
            return "[]"
        }
        var desc = "["
        for idx in front..<rear {
            desc = desc + "\(storage.itemAt(idx)), "
        }
        desc.removeAtIndex(desc.endIndex.predecessor())
        desc.removeAtIndex(desc.endIndex.predecessor())
        desc = desc + "]"
        return desc
    }
}


struct QueueGenerator<Element> : GeneratorType {
    var queue: Queue<Element>
    mutating func next() -> Element? {
        return queue.dequeue()
    }
}

extension Queue: SequenceType {
    func generate() -> QueueGenerator<Element> {
        return QueueGenerator<Element>(queue: self)
    }
}

var intQueue = Queue<Int>(capacity: 20)
intQueue.enqueue(11)
intQueue.enqueue(12)
intQueue.dequeue()  // Remove from front ie 11
intQueue.enqueue(13)

print("Print elements in queue")
for i in intQueue {
    print(i)
}

let queueValuesMultipliedByTwo = intQueue.map { $0 * 2 }
print(queueValuesMultipliedByTwo)


class Foo : CustomStringConvertible {
    let tag: Int
    init(_ tag: Int) {
        self.tag = tag
    }
    deinit {
        print("Removing...\(tag)")
    }
    var description: String {
        return "#\(tag)"
    }
}

var queueClass = Queue<Foo>(capacity: 20)
queueClass.enqueue(Foo(1))
queueClass.enqueue(Foo(2))
queueClass.dequeue()
print(queueClass)
