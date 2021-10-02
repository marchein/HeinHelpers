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
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    public static func dateSuffix(date: Date, string: String) -> String {
        if Calendar.autoupdatingCurrent.isDateInYesterday(date) {
            return "\(string) - (\(NSLocalizedString("YESTERAY", comment: "Yesterday"))"
        } else if Calendar.autoupdatingCurrent.isDateInToday(date) {
            return "\(string) - (\(NSLocalizedString("TODAY", comment: "Today"))"
        } else if Calendar.autoupdatingCurrent.isDateInTomorrow(date) {
            return  "\(string) - (\(NSLocalizedString("TOMORROW", comment: "Tomorrow"))"
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
