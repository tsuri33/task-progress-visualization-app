import SwiftUI
import RealmSwift

struct TaskSecondStartPage: View {
    
    @Binding var taskName:String
    
    var body: some View {
        ZStack {
            let realm = try! Realm()
            let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
            Form {
                Section {
                    Text("a")
                }
            }
        }
    }
}

struct TaskSecondStartPage_Previews: PreviewProvider {
    static var previews: some View {
        TaskSecondStartPage(taskName: .constant("数学"))
    }
}


