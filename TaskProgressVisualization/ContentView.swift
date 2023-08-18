import SwiftUI
import RealmSwift
import AppVersionMonitorSwiftUI

struct ContentView: View {
    
    @State var isAlert: Bool = false
    
    @State var selection = 0
    @AppStorage("isProgressionTask") var isProgressionTask = false
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
            TaskList(isProgressionTask: self.$isProgressionTask, selection: self.$selection, taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period)
                .tabItem() {
                    Label("リスト", systemImage: "list.bullet.clipboard")
                }
                .tag(0)
            if isProgressionTask {
                MainPage(progressValue: self.$progressValue, isProgressionTask: self.$isProgressionTask, selection: self.$selection, taskName: self.$taskName, taskAmount: self.$taskAmount, taskCompletedAmount: self.$taskCompletedAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period, daysLeftRatio: self.$daysLeftRatio, numberDoTask: self.$numberDoTask)
                    .tabItem() {
                        Label("メイン", systemImage: "flag.checkered")
                    }
                    .tag(1)
                    .badge("進行中")
            } else {
                MainPage(progressValue: self.$progressValue, isProgressionTask: self.$isProgressionTask, selection: self.$selection, taskName: self.$taskName, taskAmount: self.$taskAmount, taskCompletedAmount: self.$taskCompletedAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period, daysLeftRatio: self.$daysLeftRatio, numberDoTask: self.$numberDoTask)
                    .tabItem() {
                        Label("メイン", systemImage: "flag.checkered")
                    }
                    .tag(1)
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

