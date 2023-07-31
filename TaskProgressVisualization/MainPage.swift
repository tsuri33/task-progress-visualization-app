import SwiftUI
import RealmSwift

struct MainPage: View {
    
    private var frameWidth: CGFloat {UIScreen.main.bounds.width}
    @Binding var progressValue:Double
    @Binding var isProgressionTask:Bool
    
    @State private var isAlert = false
    
    @Binding var taskName:String
    @Binding var amountTask:Int
    @Binding var amountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    
    @Binding var differenceOfDate:Int
    @Binding var storeFirstDifferenceOfDate:Int
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(taskName)").font(.title)
            }
            ZStack {
                // 外円
                CircularProgressBar(progress: $progressValue, color: .blue, selectionDate: self.$selectionDate)
                    .frame(width: frameWidth, height: frameWidth-130)
                    .padding()
                // 内円
                var daysLeftsRatio = Double(differenceOfDate) / Double(storeFirstDifferenceOfDate)
                CircularProgressBar(progress: Binding<Double>(get: { Double(daysLeftsRatio) }, set: { daysLeftsRatio = Double($0) }), color: .red, selectionDate: self.$selectionDate)
                    .frame(width: frameWidth,height: frameWidth-230)
            }.padding()
            
            HStack {
                HStack {
                    Text("達成率").font(.title3)
                    Text("\(Int(progressValue*100))").font(.largeTitle)
                    Text("%").font(.title3)
                    Text("|").font(.title)
                    Text("残り\(Int(Double(amountTask)*(1.0-progressValue)))")
                }
            }
            
            ButtonView(buttonText: "今日の分クリア！", width: 170, color: Color.blue, action: {
                // 小数点のズレを修正(double)
                let raitoPerDay = Double(amountToAdvancePerDay) / Double(amountTask)
                progressValue += raitoPerDay
                print(Double(storeFirstDifferenceOfDate))
                print(progressValue)
                
                let realm = try! Realm()
                let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
                do {
                    try realm.write {
                        taskData.setValue(Date(), forKey: "lastDate")
                    }
                } catch {
                    print("データベース更新エラー")
                }
                
                if progressValue >= 1 {
                    isProgressionTask.toggle()
                    progressValue = 0
                }
            }).padding()
            
            ButtonView(buttonText: "この課題を諦める", width: 170, color: .red, action: {
                isAlert = true
            })
            .alert(isPresented: $isAlert) {
                Alert(title: Text("今回の記録は失われます"), message: Text("本当にタスクを終了しますか？"), primaryButton: .default(Text("いいえ")), secondaryButton: .default(Text("はい"), action: {
                    isProgressionTask = false
                    progressValue = 0.0
                    // データベース削除
                    let realm = try! Realm()
                    let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
                    do {
                        try realm.write {
                            realm.delete(taskData)
                        }
                    } catch {
                        print("データベース削除エラー")
                    }
                }))
            }
            
            Button(action: {
                let realm = try! Realm()
                let taskTable = realm.objects(Task.self)
                print(taskTable)
            }, label: {
                Text("データベース取得")
            }).padding()
            
            Button(action: {
                let realm = try! Realm()
                try! realm.write {
                    let taskTable = realm.objects(Task.self)
                    realm.delete(taskTable)
                }
            }, label: {
                Text("データベース削除")
            }).padding()
            
            Button(action: {
                if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
                    try! FileManager.default.removeItem(at: fileURL)
                }
            }, label: {
                Text("アプリ内からデータベースファイルごと削除")
            }).padding()
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(progressValue: .constant(0.5), isProgressionTask: .constant(true), taskName: .constant("数学"), amountTask: .constant(10), amountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), differenceOfDate: .constant(1), storeFirstDifferenceOfDate: .constant(1))
    }
}
