import SwiftUI

struct ContentView: View {
    
    @State var selection = 1
    @AppStorage("isProgressionTask") var isProgressionTask = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.quaternaryLabel
    }
    
    @State  var taskName = ""
    @State  var amountTask = 1
    @State  var amountToAdvancePerDay = 1
    @State  var selectionDate = Date()
    @State  var numberDoTask = 1
    
    @State var differenceOfDate = 0
    @State var storeFirstDifferenceOfDate = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            if !isProgressionTask {
                TaskList(isProgressionTask: self.$isProgressionTask, taskName: self.$taskName, amountTask: self.$amountTask, amountToAdvancePerDay: self.$amountToAdvancePerDay, selectionDate: self.$selectionDate, numberDoTask: self.$numberDoTask, storeFirstDifferenceOfDate: self.$storeFirstDifferenceOfDate)
                    .tabItem() {
                        Label("タスク", systemImage: "note.text")
                    }.tag(1)
            } else {
                MainPage(isPregressionTask: self.$isProgressionTask, taskName: self.$taskName, amountTask: self.$amountTask, amountToAdvancePerDay: self.$amountToAdvancePerDay, selectionDate: self.$selectionDate, differenceOfDate: self.$differenceOfDate, storeFirstDifferenceOfDate: self.$storeFirstDifferenceOfDate)
                    .tabItem() {
                        Label("タスク", systemImage: "note.text")
                    }.tag(1)
            }
            SettingPage(isProgressionTask: self.$isProgressionTask, taskName: self.$taskName, amountTask: self.$amountTask, amountToAdvancePerDay: self.$amountToAdvancePerDay, selectionDate: self.$selectionDate, numberDoTask: self.$numberDoTask)
                .tabItem() {
                    Label("設定", systemImage: "gearshape")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

