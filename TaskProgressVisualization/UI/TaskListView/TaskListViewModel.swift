import Foundation

class TaskListViewModel: ObservableObject {
    @Published var isAlert: Bool = false
    @Published var isShowModal = false
}
