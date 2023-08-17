import SwiftUI
import RealmSwift

struct TaskList: View {
    
    private var frameWidth: CGFloat {UIScreen.main.bounds.width}
    private var frameHeight: CGFloat {UIScreen.main.bounds.height}
    
    @State var showingModal = false
    @State var showingSecondModal = false
    @Binding var isProgressionTask:Bool
    @Binding var selection:Int
    
    @State private var tasks: Results<Task> = try! Realm().objects(Task.self)
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    @Binding var period:Int
//    @Binding var numberDoTask:Int
    
    var body: some View {
        VStack {
            Spacer()
            Text("完了タスク一覧")
                .font(.largeTitle)
            Spacer()
            Text("達成タスク数：\(tasks.count)個").font(.title3)
            Spacer()
            List {
                ForEach(0 ..< tasks.count, id: \.self) { index in
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 8)
                            .padding()
                        Text("\(tasks[index].name)")
                            .font(.title3)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            // データベース削除
                            let realm = try! Realm()
                            let taskIdToDelete = tasks[index].id
                            if let taskDelete = realm.object(ofType: Task.self, forPrimaryKey: taskIdToDelete) {
                                do {
                                    try realm.write {
                                        realm.delete(taskDelete)
                                    }
                                } catch {
                                    print("データベース削除エラー")
                                }
                            }
                            tasks = realm.objects(Task.self)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                    /*
                    .swipeActions(edge: .leading) {
                        Button {
                            // 2回目以降のタスク開始画面
                            showingSecondModal.toggle()
                            print(showingSecondModal)
                        } label: {
                            Image(systemName: "play")
                        }
                        .tint(.green)
                    }
                    2回目以降のタスク開始ページ
                    .sheet(isPresented: $showingSecondModal) {
                        TaskSecondStartPage(taskName: self.$taskName, amountTask: self.$amountTask)
                    }
                     */
                }
            }
            Spacer()
            if isProgressionTask {
                ZStack {
                    Color.gray.frame(width: 300, height: 50)
                        .cornerRadius(25)
                        .shadow(radius: 10)
                    Text("進行中のタスクを終わらせよう！")
                        .foregroundColor(.white)
                }
            } else {
                ButtonView(buttonText: "新しいタスクを開始する！", width: 300, color: .blue, action: {
                    self.showingModal.toggle()
                }).sheet(isPresented: $showingModal) {
                    TaskStartPage(isProgressionTask: self.$isProgressionTask, showingModal: self.$showingModal, selection: self.$selection, taskName: self.$taskName, taskAmount: self.$taskAmount, taskAmountToAdvancePerDay: self.$taskAmountToAdvancePerDay, selectionDate: self.$selectionDate, period: self.$period)
                }
            }
            Spacer()
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(isProgressionTask: .constant(false), selection: .constant(0), taskName: .constant("数学"), taskAmount: .constant(10), taskAmountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), period: .constant(10))
    }
}
