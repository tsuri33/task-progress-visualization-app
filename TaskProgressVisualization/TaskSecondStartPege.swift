import SwiftUI
import RealmSwift

struct TaskSecondStartPage: View {
    // タスクが2回目以降の時に表示するビュー
    
    @Binding var taskName:String
    @Binding var amountTask:Int
    
    var body: some View {
        // 要素を抽出して出力する方法について調べる必要あり
        let realm = try! Realm()
        let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
        VStack {
            Form {
                Section {
                    Text("a")
                } header: {
                    Text("前回までの記録")
                }
                Section {
                    Text("b")
                } header: {
                    Text("今回の設定")
                }
            }
            // スタートボタンビュー
            
            Button(action: {
                print(taskData)
            } ,label: {
                Text("データベース")
            })
        }
    }
}

struct TaskSecondStartPage_Previews: PreviewProvider {
    static var previews: some View {
        TaskSecondStartPage(taskName: .constant("数学"), amountTask: .constant(100))
    }
}


