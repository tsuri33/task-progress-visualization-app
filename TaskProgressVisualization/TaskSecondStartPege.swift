import SwiftUI
import RealmSwift

struct TaskSecondStartPage: View {
    
    @Binding var taskName:String
    
    var body: some View {
        let realm = try! Realm()
        let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
        VStack {
            Form {
                Section {
                    Text("a")
                } header: {
                    Text("前回までの記録")
                }
            }
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
        TaskSecondStartPage(taskName: .constant("数学"))
    }
}


