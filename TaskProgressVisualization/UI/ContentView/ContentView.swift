import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        
        TabView(selection: $viewModel.selection) {
            
            TaskListView(viewModel: TaskListViewModel())
                .tabItem {
                    Label("リスト", systemImage: "list.bullet.clipboard")
                }
                .tag(1)

            SettingPage()
                .tabItem {
                    Label("設定", systemImage: "gearshape")
                }
                .tag(2)
            }
        }
    }

#Preview {
    ContentView(viewModel: ContentViewModel())
}
