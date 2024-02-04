import SwiftUI
import RealmSwift

struct CircularProgressBar: View {
    
    @Binding var isProgressionTask:Bool
    
    @Binding var progress:Double
    var color: Color
    @AppStorage("differenceOfDate") var differenceOfDate = 0
    @Binding var period:Int
    @Binding var selectionDate:Date
    @Binding var daysLeftRatio:Double
    
    var body: some View {
        
        if isProgressionTask {
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
                    Text("\(differenceOfDate)日").font(.largeTitle)
                }.onAppear {
                    let realm = try! Realm()
                    let taskSelectionDate = realm.objects(TaskSelectionDate.self)
                    selectionDate = taskSelectionDate[0].selectionDate
                    differenceOfDate = Int(selectionDate.timeIntervalSince(Date()) / (60 * 60 * 24)) + 1
                    daysLeftRatio = 1.0 - Double(differenceOfDate * 100 / period) / 100
                }
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

struct TaskList: View {
    
    var taskName: String
    
    var body: some View {
        
        Text(taskName)
            .padding(20)
    }
}
