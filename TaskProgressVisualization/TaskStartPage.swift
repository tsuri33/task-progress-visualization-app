import SwiftUI
import RealmSwift

struct TaskStartPage: View {
    
    @State var isAlert = false
    @Binding var isProgressionTask:Bool
    @Binding var showingModal:Bool
    @Binding var selection:Int
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    @Binding var period:Int
//    @Binding var numberDoTask:Int
    
    var body: some View {
        VStack {
            TaskStartSettingView(taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate)
            ButtonView(buttonText: "このタスクを開始する！", width: 220, color: .blue, action: {
                
                if self.taskName == "" || self.taskAmount == 0 || self.taskAmountToAdvancePerDay == 0 {
                    self.isAlert.toggle()
                } else {
                    period = Int(selectionDate.timeIntervalSince(Date()) / (60 * 60 * 24)) + 1
                    let taskSelectionDate = TaskSelectionDate()
                    taskSelectionDate.selectionDate = selectionDate
                    // 保存
                    do {
                        let realm = try Realm()
                        try! realm.write {
                            realm.add(taskSelectionDate)
                        }
                    } catch let error as NSError {
                        print("Realm 初期化エラー: \(error.localizedDescription)")
                    }
                    isProgressionTask = true
                    showingModal = false
                    selection = 1
                }
            }).alert(isPresented: self.$isAlert) {
                Alert(title: Text("全ての項目を入力してください"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct TaskStartPage_Previews: PreviewProvider {
    static var previews: some View {
        TaskStartPage(isProgressionTask: .constant(false), showingModal: .constant(false), selection: .constant(0), taskName: .constant("数学"), taskAmount: .constant(10), taskAmountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), period: .constant(10))
    }
}
