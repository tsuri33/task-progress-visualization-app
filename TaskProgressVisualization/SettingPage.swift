import SwiftUI
import RealmSwift

struct SettingPage: View {
    
    @State private var isAlert = false
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @Binding var selectionDate:Date
//    @Binding var numberDoTask:Int
    
    @Binding var progressValue:Double
    
    // データベースと連動させる
    // 変数の変更を保存
    var body: some View {
        Text("設定")
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage(taskName: .constant("数学"), taskAmount: .constant(10), taskAmountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), progressValue: .constant(1.0) )
    }
}
