import Foundation

class TaskStartViewModel: ObservableObject {
    @Published var taskName = ""
    @Published var taskAmount = 0
    @Published var selectedUnits = ""
    @Published var taskUnits = ["ページ", "問", "個", "章", "枚"]
    @Published var selectionDate = Date()
    @Published var taskAmountToAdvancePerDay = 0
    @Published var period = 0
    
    @Published var isAlert = false
}
