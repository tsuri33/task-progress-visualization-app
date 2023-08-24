import SwiftUI
import RealmSwift

struct MainPage: View {
    
    private var frameWidth: CGFloat {UIScreen.main.bounds.width}
    private var frameHeight: CGFloat {UIScreen.main.bounds.height}
    
    @Binding var progressValue:Double
    @Binding var isProgressionTask:Bool
    @State private var isAlert = false
    @Binding var selection:Int
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskCompletedAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @Binding var selectionDate:Date
    @Binding var period:Int
    @Binding var daysLeftRatio:Double
    @Binding var numberDoTask:Int
    
    @AppStorage("rateOfAchievement") var rateOfAchievement = 0
    
    var body: some View {
        
        let realm = try! Realm()
        let taskSelectionDate = realm.objects(TaskSelectionDate.self)
        
        if isProgressionTask {
            
            ZStack(alignment: .topTrailing) {
                
                Button(action: {
                    taskCompletedAmount -= taskAmountToAdvancePerDay
                    if taskCompletedAmount < 0 {
                        taskCompletedAmount = 0
                    }
                    rateOfAchievement = taskCompletedAmount * 100 / taskAmount
                    progressValue = Double(taskCompletedAmount*100/taskAmount)/100
                }, label: {
                    Image(systemName: "gobackward.minus")
                        .resizable()
                        .frame(width: 35, height: 35)
                }).padding(.trailing, frameWidth-350)
                
                VStack {
                    Spacer()
                    Text("\(taskName)")
                        .font(.title)
                    if taskCompletedAmount + taskAmountToAdvancePerDay > taskAmount {
                        Spacer()
                        Text("次の目標：\(taskAmount)  まで")
                            .font(.title3)
                    } else {
                        Spacer()
                        Text("次の目標：\(taskCompletedAmount + taskAmountToAdvancePerDay)  まで")
                            .font(.title3)
                    }
                    Spacer()
                    ZStack {
                        // 外円
                        CircularProgressBar(progress: $progressValue, color: .blue, period: self.$period, selectionDate: self.$selectionDate, daysLeftRatio: self.$daysLeftRatio)
                            .frame(width: 250, height: 250)
                            .padding()
                        // 内円
                        CircularProgressBar(progress: $daysLeftRatio, color: .red, period: self.$period, selectionDate: self.$selectionDate, daysLeftRatio: self.$daysLeftRatio)
                            .frame(width: 150, height: 150)
                        
                    }
                    Spacer()
                    HStack {
                        HStack {
                            Text("達成率").font(.title3)
                            Text("\(rateOfAchievement)")
                                .font(.largeTitle)
                            Text("%").font(.title3)
                            Text("|").font(.title)
                            Text("残り\(taskAmount-taskCompletedAmount)")
                        }
                    }
                    Spacer()
                    
                    ButtonView(buttonText: "今日の分クリア！", width: 200, color: Color.blue, action: {
                        
                        taskCompletedAmount += taskAmountToAdvancePerDay
                        rateOfAchievement = taskCompletedAmount * 100 / taskAmount
                        progressValue = Double(taskCompletedAmount*100/taskAmount)/100
                        
                        // タスク終了時の処理
                        if taskAmount <= taskCompletedAmount {
                            // レコード生成
                            let task = Task()
                            task.name = taskName
                            task.amount = taskAmount
                            task.amountToAdvancePerDay = taskAmountToAdvancePerDay
                            task.lastDate = Date()
                            task.period = period
                            task.numberDoTask = numberDoTask + 1
                            // 保存
                            do {
                                let realm = try Realm()
                                try! realm.write {
                                    realm.add(task)
                                }
                            } catch let error as NSError {
                                print("Realm 初期化エラー: \(error.localizedDescription)")
                            }
                            
                            progressValue = 0.0
                            taskAmount = 1
                            taskAmountToAdvancePerDay = 1
                            taskCompletedAmount = 0
                            rateOfAchievement = 0
                            
                            if let selectionDateToDelete = taskSelectionDate.first {
                                do {
                                    try realm.write {
                                        realm.delete(selectionDateToDelete)
                                    }
                                } catch {
                                    print("データベース削除エラー")
                                }
                            }
                            selection = 0
                            isProgressionTask = false
                        }
                    }).padding()
                    
                    ButtonView(buttonText: "このタスクをやめる", width: 200, color: .red, action: {
                        isAlert = true
                    })
                    .alert(isPresented: $isAlert) {
                        Alert(title: Text("今回の記録は失われます"), message: Text("本当にタスクを終了しますか？"), primaryButton: .default(Text("いいえ")), secondaryButton: .default(Text("はい"), action: {
                            progressValue = 0.0
                            taskAmount = 1
                            taskAmountToAdvancePerDay = 1
                            taskCompletedAmount = 0
                            rateOfAchievement = 0
                            
                            // taskSelectionDateを削除
                            if let selectionDateToDelete = taskSelectionDate.first {
                                do {
                                    try realm.write {
                                        realm.delete(selectionDateToDelete)
                                    }
                                } catch {
                                    print("データベース削除エラー")
                                }
                            }
                            isProgressionTask = false
                            selection = 0
                        }))
                    }
                    .padding(.bottom, 20)
                }.frame(maxWidth: frameWidth, maxHeight: frameHeight)
            }
        } else {
            Text("タスクを開始してください！").font(.title)
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(progressValue: .constant(0.5), isProgressionTask: .constant(true), selection: .constant(1), taskName: .constant("数学"), taskAmount: .constant(100), taskCompletedAmount: .constant(20), taskAmountToAdvancePerDay: .constant(1), selectionDate: .constant(Date()), period: .constant(20), daysLeftRatio: .constant(0.6), numberDoTask: .constant(0))
    }
}
