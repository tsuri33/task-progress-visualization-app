import SwiftUI
import RealmSwift

struct CircularProgressBar: View {
    
    @Binding var progress:Double
    var color: Color
    @AppStorage("differenceOfDate") var differenceOfDate = 0
    @Binding var period:Int
    @Binding var selectionDate:Date
    @Binding var daysLeftRatio:Double
    
    var body: some View {
        
        ZStack {
            // 背景の円
            Circle()
                .stroke(lineWidth: 35.0)
                .opacity(0.3)
                .foregroundColor(color)
            // 進捗度を表す円
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 35, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
            VStack {
                Text("残り").font(.title)
                // 日付表示修正の必要あり
                Text("\(differenceOfDate)日").font(.largeTitle)
            }.onAppear {
                let realm = try! Realm()
                let taskSelectionDate = realm.objects(TaskSelectionDate.self)
                selectionDate = taskSelectionDate[0].selectionDate
                differenceOfDate = Int(selectionDate.timeIntervalSince(Date()) / (60 * 60 * 24)) + 1
                print(daysLeftRatio)
            }
        }
    }
}

struct ButtonView: View {
    
    var buttonText: String
    var width: CGFloat
    var color: Color
    var action: () -> Void
    
    var body: some View {
        
        ZStack {
            Color.white.frame(width: width, height: 50)
                .cornerRadius(25)
                .shadow(radius: 10)
            
            Button (action: action) {
                Text(buttonText)
                    .scaledToFill()
                    .foregroundColor(color)
            }
        }
    }
}

struct TaskStartSettingView: View {
    
    @Binding var taskName:String
    @Binding var taskAmount:Int
    @Binding var taskAmountToAdvancePerDay:Int
    @State var taskUnits = ["ページ", "問", "個"]
    @State var selectedUnits = 0
    @Binding var selectionDate:Date
//    @Binding var numberDoTask:Int
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("タスク名：")
                        TextField("タスク名をここに入力", text: $taskName)
                            .multilineTextAlignment(TextAlignment.center)
                    }.padding()
                    
                    HStack {
                        Text("タスクの量：")
                        TextField("1", value: $taskAmount, format: .number)
                            .multilineTextAlignment(TextAlignment.trailing)
                        Picker(selection: $selectedUnits, label: Text("")) {
                            ForEach(taskUnits.indices, id: \.self) { unitsIndex in
                                Text(self.taskUnits[unitsIndex])
                            }
                        }.labelsHidden()
                    }.padding()
                    
                    HStack {
                        Text("1日に進める量：")
                        Picker("", selection: $taskAmountToAdvancePerDay) {
                            ForEach(0...taskAmount, id: \.self) { value in
                                Text("\(value)")
                            }
                        }
                        .frame(height: 100)
                        .clipped()
                        .pickerStyle(.wheel)
                        
                        Picker(selection: $selectedUnits, label: Text("")) {
                            ForEach(taskUnits.indices, id: \.self) { unitsIndex in
                                Text(self.taskUnits[unitsIndex])
                            }
                        }.labelsHidden()
                    }.padding()
                    
                    HStack {
                        Text("終わらせたい日：")
                        DatePicker("", selection: $selectionDate, in: Date()..., displayedComponents: .date)
                    }.padding()
                    
                }
            }.padding(.bottom)
        }
    }
}

struct TaskListView: View {
    
    var taskName: String
    
    var body: some View {
        
        Text(taskName)
            .padding(20)
    }
}
