import Foundation
import RealmSwift

class Task: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name:String
    @Persisted var amount:Int
    @Persisted var completedAmount:Int
    @Persisted var advanceAmountPerDay:Int
    @Persisted var lastDate:Date
    @Persisted var deadline:Int
    @Persisted var numberDoTask:Int
    @Persisted var isProgressing:Bool
    @Persisted var progressValue:Double
    @Persisted var rateOfAchievement:Int
    @Persisted var selectionDate:Date
}

class TaskSelectionDate: Object {
    @Persisted var selectionDate:Date
}
