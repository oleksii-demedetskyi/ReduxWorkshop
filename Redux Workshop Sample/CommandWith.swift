struct CommandWith<T> {
    private let _perform: (T) -> ()
    
    init(perform: @escaping (T) -> ()) {
        _perform = perform
    }
    
    func perform(with value: T) {
        _perform(value)
    }
}

typealias Command = CommandWith<Void>

extension CommandWith where T == Void {
    func perform() {
        self.perform(with: Void())
    }
}
