import Foundation
import RealmSwift

class Task: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var taskName:String
    @Persisted var amountTask:Int
    @Persisted var amountToAdvancePerDay:Int
    @Persisted var lastDate:Date
    @Persisted var numberDoTask:Int
}
