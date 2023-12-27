import Foundation
import RealmSwift

struct RealmHelper {
    
    let realm = try! Realm()
    
    func save(model: Object, action: () -> Void) {
        action()
        try! realm.write {
            realm.add(model)
        }
    }
    
    func read<T: Object>(modelType: T.Type) {
        let modelTable = realm.objects(modelType)
        print(modelTable)
    }
    
    func update(model: Object, updateParts: () -> Void) {
        updateParts()
        try! realm.write {
            realm.add(model, update: .modified)
        }
    }
    
    func deleteTable(model: Object) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func deletePart<T: Object>(modelType: T.Type, conditions: @escaping (T) -> Bool) {
        do {
            let realm = try Realm()
            if let delete = realm.objects(modelType).first(where: { conditions($0) }) {
                try! realm.write {
                    realm.delete(delete)
                }
            } else {
                print("条件に一致するオブジェクトが見つかりませんでした。")
            }
        } catch let error as NSError {
            print("Realm 初期化エラーまたは削除エラー: \(error.localizedDescription)")
        }
    }
}
