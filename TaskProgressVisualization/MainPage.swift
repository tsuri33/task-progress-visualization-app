import SwiftUI
import RealmSwift

struct MainPage: View {
    
    private var frameWidth: CGFloat {UIScreen.main.bounds.width}
    @Binding var progressValue:Double
    @Binding var isProgressionTask:Bool
    
    @State private var isAlert = false
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskCompletedAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    @Binding var period:Int
    @Binding var daysLeftRatio:Double
    
    @Binding var differenceOfDate:Int
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Button(action: {
                if differenceOfDate >= 0 {
                    daysLeftRatio = Double(differenceOfDate*100 / period)/100
                } else {
                    daysLeftRatio = 1.0
                }
                print(differenceOfDate)
                print(daysLeftRatio)
            }, label: {
                Image(systemName: "restart.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
            }).padding(.trailing, 60.0)
            
            VStack {
                
                Text("\(taskName)").font(.title)
                
                ZStack {
                    // 外円
                    CircularProgressBar(progress: $progressValue, color: .blue, period: self.$period, selectionDate: self.$selectionDate, daysLeftRatio: self.$daysLeftRatio)
                        .frame(width: frameWidth, height: frameWidth - 130)
                        .padding()
                    // 内円
                    CircularProgressBar(progress: $daysLeftRatio, color: .red, period: self.$period, selectionDate: self.$selectionDate, daysLeftRatio: self.$daysLeftRatio)
                        .frame(width: frameWidth, height: frameWidth - 230)

                }.padding()
                
                HStack {
                    HStack {
                        Text("達成率").font(.title3)
                        Text("\(taskCompletedAmount*100/taskAmount)")
                            .font(.largeTitle)
                        Text("%").font(.title3)
                        Text("|").font(.title)
                        Text("残り\(taskAmount-taskCompletedAmount)")
                    }
                }
                
                VStack {
                    ButtonView(buttonText: "今日の分クリア！", width: 180, color: Color.blue, action: {
                        
                        taskCompletedAmount += taskAmountToAdvancePerDay
                        progressValue = Double(taskCompletedAmount*100/taskAmount)/100
                        
                        let realm = try! Realm()
                        let taskData = realm.objects(Task.self).filter("name == '\(taskName)'")
                        do {
                            try realm.write {
                                taskData.setValue(Date(), forKey: "lastDate")
                            }
                        } catch {
                            print("データベース更新エラー")
                        }
                        
                        if taskAmount <= taskCompletedAmount {
                            isProgressionTask.toggle()
                            progressValue = 0.0
                            taskCompletedAmount = 0
                        }
                        
                        print(progressValue)
                        print(daysLeftRatio)
                    }).padding()
                    
                    ButtonView(buttonText: "このタスクをやめる", width: 180, color: .red, action: {
                        isAlert = true
                    })
                    .alert(isPresented: $isAlert) {
                        Alert(title: Text("今回の記録は失われます"), message: Text("本当にタスクを終了しますか？"), primaryButton: .default(Text("いいえ")), secondaryButton: .default(Text("はい"), action: {
                            isProgressionTask = false
                            progressValue = 0.0
                            // データベース削除
                            let realm = try! Realm()
                            let taskDelete = realm.objects(Task.self).filter("name == '\(taskName)'")
                            do {
                                try realm.write {
                                    realm.delete(taskDelete)
                                }
                            } catch {
                                print("データベース削除エラー")
                            }
                        }))
                    }
                }
                
                Button(action: {
                    let realm = try! Realm()
                    print(Realm.Configuration.defaultConfiguration.fileURL!)
                    let taskTable = realm.objects(Task.self)
                    print(taskTable)
                }, label: {
                    Text("データベース取得")
                }).padding()
                
                //            Button(action: {
                //                let realm = try! Realm()
                //                try! realm.write {
                //                    let taskTable = realm.objects(Task.self)
                //                    realm.delete(taskTable)
                //                }
                //            }, label: {
                //                Text("データベース削除")
                //            }).padding()
                //
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
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(progressValue: .constant(0.5), isProgressionTask: .constant(true), taskName: .constant("数学"), taskAmount: .constant(100), taskCompletedAmount: .constant(20), taskAmountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), period: .constant(20), daysLeftRatio: .constant(0.6), differenceOfDate: .constant(10))
    }
}
