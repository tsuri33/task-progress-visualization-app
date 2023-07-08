import Foundation
import RealmSwift

class Task: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name:String
    @Persisted var amountTask:Int
    @Persisted var amountToAdvancePerDay:Int
    @Persisted var lastDate:Date
    @Persisted var numberDoTask:Int
}

class Data: Object {
    @Persisted var daysLeftsRatio:Double
}
