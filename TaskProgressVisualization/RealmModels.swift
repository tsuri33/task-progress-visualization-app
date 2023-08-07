import Foundation
import RealmSwift

class Task: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name:String
    @Persisted var amount:Int
    @Persisted var amountToAdvancePerDay:Int
    @Persisted var lastDate:Date
    @Persisted var period:Int
}
