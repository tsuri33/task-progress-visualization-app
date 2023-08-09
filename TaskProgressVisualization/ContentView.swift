import SwiftUI

struct ContentView: View {
    
    @State var selection = 1
    @AppStorage("isProgressionTask") var isProgressionTask = false
    @AppStorage("progressValue") var progressValue = 0.0
    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.quaternaryLabel
//    }
    
    @State var taskName = ""
    @State var taskAmount = 1
    @State var taskCompletedAmount = 0
    @State var taskAmountToAdvancePerDay = 1
    @AppStorage("period") var period = 0
    @State var selectionDate = Date()
    @State var daysLeftRatio = 0.0
//    @State  var numberDoTask = 0
    
    @State var differenceOfDate = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            if !isProgressionTask {
                TaskList(isProgressionTask: self.$isProgressionTask, taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period)
//                    .tabItem() {
//                        Label("タスク", systemImage: "note.text")
//                    }.tag(1)
            } else {
                MainPage(progressValue: self.$progressValue, isProgressionTask: self.$isProgressionTask, taskName: self.$taskName, taskAmount: self.$taskAmount, taskCompletedAmount: self.$taskCompletedAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period, daysLeftRatio: self.$daysLeftRatio, differenceOfDate: self.$differenceOfDate)
//                    .tabItem() {
//                        Label("タスク", systemImage: "note.text")
//                    }.tag(1)
            }
//            SettingPage(isProgressionTask: self.$isProgressionTask, taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, progressValue: self.$progressValue)
//                .tabItem() {
//                    Label("設定", systemImage: "gearshape")
//                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

