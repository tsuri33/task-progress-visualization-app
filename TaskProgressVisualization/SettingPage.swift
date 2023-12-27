import SwiftUI
import RealmSwift

struct SettingPage: View {
    
    @State private var isAlert = false
    @Binding var isProgressionTask:Bool
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @Binding var selectionDate:Date
//    @Binding var numberDoTask:Int
    
    @Binding var progressValue:Double
    
    // データベースと連動させる
    // 変数の変更を保存
    var body: some View {
        if isProgressionTask {
            VStack {
                Text("設定").font(.largeTitle).padding()
                TaskStartSettingView(taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate)
                
                ButtonView(buttonText: "現在進行中のタスクを終了する", width: 280, color: .red, action: {
                    isAlert = true
                }).padding(.bottom)
                    .alert(isPresented: $isAlert) {
                        Alert(title: Text("今回の記録は失われます"), message: Text("本当にタスクを終了しますか？"), primaryButton: .default(Text("いいえ")), secondaryButton: .default(Text("はい"), action: {
                            isProgressionTask = false
                            progressValue = 0.0
                            // データベース削除
                            let realm = try! Realm()
                            let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
                            do {
                                try realm.write {
                                    realm.delete(taskData)
                                }
                            } catch {
                                print("データベース削除エラー")
                            }
                        }))
                    }
            }
        } else {
            Text("タスクを開始してください！").font(.title)
        }
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage(isProgressionTask: .constant(true), taskName: .constant("数学"), taskAmount: .constant(10), taskAmountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), progressValue: .constant(1.0) )
    }
}
