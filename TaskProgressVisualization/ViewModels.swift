import Foundation

class ContentViewModel: ObservableObject {
    @Published var selection = 1
}

class TaskListViewModel: ObservableObject {
    @Published var isAlert: Bool = false
    @Published var isShowModal = false
}
