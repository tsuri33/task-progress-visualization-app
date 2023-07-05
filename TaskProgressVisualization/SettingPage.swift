import SwiftUI

struct SettingPage: View {
    
    @State private var isAlert = false
    @Binding var isProgressionTask:Bool
    
    @Binding var taskName:String
    @Binding var amountTask:Int
    @Binding var amountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    @Binding var numberDoTask:Int
    
    var body: some View {
        if isProgressionTask {
            VStack {
                Text("設定").font(.largeTitle).padding()
                TaskStartSettingView(taskName: self.$taskName, amountTask: self.$amountTask, amountToAdvancePerDay: self.$amountToAdvancePerDay, selectionDate: self.$selectionDate, numberDoTask: self.$numberDoTask)
                ButtonView(buttonText: "現在進行中のタスクを終了する", width: 280, color: .red, action: {
                    isAlert = true
                }).padding(.bottom)
                    .alert(isPresented: $isAlert) {
                        Alert(title: Text("今回の記録は失われます"), message: Text("本当にタスクを終了しますか？"), primaryButton: .default(Text("いいえ")), secondaryButton: .default(Text("はい"), action: {
                            isProgressionTask = false
                            // ここにデータベース削除のコード
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
        SettingPage(isProgressionTask: .constant(true), taskName: .constant("数学"), amountTask: .constant(10), amountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), numberDoTask: .constant(1) )
    }
}
