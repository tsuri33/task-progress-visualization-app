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
        .alert(isPresented: $isAlert) {
            Alert(title: Text("お知らせ"), message: Text("最新バージョンがあります"), dismissButton: .default(Text("OK")) {
                // AppStoreを開く
                let url = URL(string: "https://apps.apple.com/app/%E3%82%BF%E3%82%B9%E3%82%AF%E9%80%B2%E6%8D%97%E5%BA%A6%E5%8F%AF%E8%A6%96%E5%8C%96%E3%82%A2%E3%83%97%E3%83%AA/id6461378188")!
                // URLを開けるかをチェックする
                if UIApplication.shared.canOpenURL(url) {
                    // URLを開く
                    UIApplication.shared.open(url, options: [:])
                }
            })
        }
        .appVersionMonitor(id: 6461378188) { status in
            switch status {
            case .updateAvailable:
                isAlert = true
                print("アップデートがあります")
            case .updateUnavailable:
                print("アップデートがありません")
            case .failure(let error):
                print("エラーが発生しました: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

