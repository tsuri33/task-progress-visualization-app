import SwiftUI
import RealmSwift

struct TaskList: View {
    
    private var frameWidth: CGFloat {UIScreen.main.bounds.width}
    @State var taskNumber:Int = 3
    @State var showingModal = false
    @Binding var isProgressionTask:Bool
    
    @Binding var taskName:String
    @Binding var amountTask:Int
    @Binding var amountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    @Binding var numberDoTask:Int
    
    @Binding var storeFirstDifferenceOfDate:Int
    
    var body: some View {
        let realm = try! Realm()
        let tasks = realm.objects(Task.self)
        let numberTasks = tasks.count
        VStack {
            Text("完了タスク一覧")
                .font(.largeTitle)
                .padding(.bottom)
            List {
                ForEach(0 ..< numberTasks, id: \.self) { index in
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text("\(tasks[index].taskName)")
                            .font(.title3)
                        Text("\(tasks[index].numberDoTask)回")
                            .frame(alignment: .trailing)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            // ここにタスクをデータベースから削除するコードを記述
                            print("タスク削除")
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }.padding(.bottom)
            .frame(width: frameWidth, height: 500)
            ButtonView(buttonText: "新しいタスクを開始する！", width: 250, color: .blue, action: {
                self.showingModal.toggle()
            }).sheet(isPresented: $showingModal) {
                TaskStartPage(isProgressionTask: self.$isProgressionTask, taskName: self.$taskName, amountTask: self.$amountTask, amountToAdvancePerDay: self.$amountToAdvancePerDay, selectionDate: self.$selectionDate, numberDoTask: self.$numberDoTask, storeFirstDifferenceOfDate: self.$storeFirstDifferenceOfDate)
            }
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(isProgressionTask: .constant(false), taskName: .constant("数学"), amountTask: .constant(10), amountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), numberDoTask: .constant(1), storeFirstDifferenceOfDate: .constant(100))
    }
}
