import SwiftUI
import RealmSwift

struct TaskStartView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: TaskStartViewModel
    
    var body: some View {
        Form {
            Section(header: Text("タスク名")) {
                TextField("タスク名を入力", text: $viewModel.taskName)
            }
            
            Section(header: Text("タスクの量")) {
                HStack {
                    TextField("0", value: $viewModel.taskAmount, format: .number)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(height: 40)
                    Picker(selection: $viewModel.selectedUnits, label: Text("")) {
                        ForEach(viewModel.taskUnits.indices, id: \.self) { unitsIndex in
                            Text(self.viewModel.taskUnits[unitsIndex])
                        }
                    }.labelsHidden()
                }
            }
            
            Section(header: Text("1日に進める量")) {
                HStack {
                    TextField("0", value: $viewModel.taskAmountToAdvancePerDay, format: .number)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(height: 40)
                    
                    Picker(selection: $viewModel.selectedUnits, label: Text("")) {
                        ForEach(viewModel.taskUnits.indices, id: \.self) { unitsIndex in
                            Text(viewModel.taskUnits[unitsIndex])
                        }
                    }.labelsHidden()
                }
            }
            
            Section(header: Text("タスクを終わらせたい日")) {
                DatePicker("", selection: $viewModel.selectionDate, in: Date()..., displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
            }
        }
        
        ButtonView(buttonText: "このタスクを開始する！", width: 220, color: .blue, action: {
            
            if viewModel.taskName == "" || viewModel.taskAmount == 0 || viewModel.taskAmountToAdvancePerDay == 0 {
                viewModel.isAlert = true
            } else {
                viewModel.period = Int(viewModel.selectionDate.timeIntervalSince(Date()) / (60 * 60 * 24)) + 1
                let taskSelectionDate = TaskSelectionDate()
                taskSelectionDate.selectionDate = viewModel.selectionDate
                // 保存
                do {
                    let realm = try Realm()
                    try! realm.write {
                        realm.add(taskSelectionDate)
                    }
                } catch let error as NSError {
                    print("Realm 初期化エラー: \(error.localizedDescription)")
                }
            }
        })
        .padding()
        .alert(isPresented: $viewModel.isAlert) {
            Alert(title: Text("全ての項目を入力してください"), dismissButton: .default(Text("確認")))
        }
        .navigationTitle("タスク情報を入力")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    router.navigationPath.removeLast()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 17, weight: .medium))
                        Text("戻る")
                    }
                }
            }
        }
    }
}

#Preview {
    TaskStartView(viewModel: TaskStartViewModel())
}
