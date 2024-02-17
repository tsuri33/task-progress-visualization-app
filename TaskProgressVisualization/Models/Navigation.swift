import Foundation

final class NavigationRouter: ObservableObject {
    @MainActor @Published var navigationPath: [Path] = []
  
    enum Path: Hashable {
        case list // タスク一覧画面
        case start // タスクスタート画面
        case setting // 設定画面
    }
}
