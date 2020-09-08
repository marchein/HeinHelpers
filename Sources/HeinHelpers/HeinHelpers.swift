import Foundation
#if canImport(UIKit)
import UIKit
#endif

public struct HeinHelpers {
    //MARK:- Check for Beta Testers
    public static func isSimulatorOrTestFlight() -> Bool {
        return isSimulator() || isTestFlight()
    }
    
    public static func isSimulator() -> Bool {
        guard let path = Bundle.main.appStoreReceiptURL?.path else {
            return false
        }
        return path.contains("CoreSimulator")
    }
    
    public static func isTestFlight() -> Bool {
        guard let path = Bundle.main.appStoreReceiptURL?.path else {
            return false
        }
        return path.contains("sandboxReceipt")
    }
    
    #if canImport(UIKit)
    // MARK: - showDialog
    public static func showMessage(title: String, message: String, on view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Verstanden", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            view.present(alert, animated: true)
        }
    }
    #endif
    
    /*func getShareSheet(for meal: Meal?) -> UIActivityViewController? {
     guard let meal = meal else {
     fatalError("ERROR WHILE READING MEAL")
     }
     let mealTitle = meal.title
     let mealStudentPrice = meal.getFormattedPrice(price: meal.priceStudent)!
     let textToShare = "Es gibt \(mealTitle) für \(mealStudentPrice) in der Mensa!"
     let objectsToShare = [textToShare] as [Any]
     let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
     activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
     
     return activityVC
     }
     */
    
    public static func getReleaseTitle() -> String {
        if isSimulator() {
            return "Simulator"
        } else if isTestFlight() {
            return "TestFlight"
        } else {
            return "App Store"
        }
    }
    
    public static func getDayName(by date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de_DE")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    public static func dateSuffix(date: Date, string: String) -> String {
        if Calendar.autoupdatingCurrent.isDateInYesterday(date) {
            return "\(string) - (Gestern)"
        } else if Calendar.autoupdatingCurrent.isDateInToday(date) {
            return "\(string) - (Heute)"
        } else if Calendar.autoupdatingCurrent.isDateInTomorrow(date) {
            return  "\(string) - (Morgen)"
        } else {
            return string
        }
    }
    
    public static func isDateOver(date: Date) -> Bool {
        let now = Date()
        let cal = Calendar(identifier: .gregorian)
        let newDate = cal.startOfDay(for: now)
        return date < newDate
    }
    
    public static func whenIsDate(_ date: Date) -> DAY_VALUE? {
        if Calendar.current.isDateInYesterday(date) {
            return DAY_VALUE.YESTERDAY
        } else if Calendar.current.isDateInToday(date) {
            return DAY_VALUE.TODAY
        } else if Calendar.current.isDateInTomorrow(date) {
            return DAY_VALUE.TOMORROW
        }
        return nil
    }
    
    public enum DAY_VALUE {
        case YESTERDAY
        case TODAY
        case TOMORROW
    }
}
