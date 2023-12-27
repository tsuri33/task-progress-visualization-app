import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State var selection = 0
    @AppStorage("progressValue") var progressValue = 0.0
    
    @AppStorage("taskName") var taskName = ""
    @AppStorage("taskAmount") var taskAmount = 0
    @AppStorage("taskCompletedAmount") var taskCompletedAmount = 0
    @AppStorage("taskAmountToAdvancePerDay") var taskAmountToAdvancePerDay = 0
    @AppStorage("period") var period = 0
    @State var selectionDate = Date()
    @AppStorage("daysLeftRatio") var daysLeftRatio = 0.0
    @AppStorage("numberDoTask") var numberDoTask = 0
    
    @State var differenceOfDate = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            TaskListView(viewModel: TaskListViewModel(), taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period)
                .tabItem() {
                    Label("リスト", systemImage: "list.bullet.clipboard")
                }
                .tag(0)
            }
            SettingPage(taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, progressValue: self.$progressValue)
                .tabItem() {
                    Label("設定", systemImage: "gearshape")
                }
                .tag(1)
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

