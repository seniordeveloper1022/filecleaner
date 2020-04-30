import Foundation
import UIKit
private var maxLengths = [UITextField: Int]()

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    class func hexStr(_ hexStr: String) -> UIColor {
        return UIColor.hexStr(hexStr, alpha: 1)
    }
    
    class func color(_ hexColor: ColorType) -> UIColor {
        return UIColor.hexStr(hexColor.rawValue, alpha: 1.0)
    }
    
    class func hexStr(_ str: String, alpha: CGFloat) -> UIColor {
        let hexStr = str.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b , alpha: alpha)
        } else {
            print("Invalid hex string")
            return .white
        }
    }
    
}
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    func boldString(fontSize : CGFloat ,font : UIFont?) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 8)]
        return NSMutableAttributedString(string:self, attributes:attrs)
    }
}

extension UITextField {
    
    // 3
//    @IBInspectable var maxLength: Int {
//        get {
//            // 4
//            guard let length = maxLengths[self] else {
//                return Int.max
//            }
//            return length
//        }
//        set {
//            maxLengths[self] = newValue
//            // 5
//            addTarget(
//                self,
//                action: #selector(limitLength),
//                for: UIControlEvents.editingChanged
//            )
//        }
//    }
//    
    
    
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}


class Utilities {
    
   static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

 static func readJson(fileName:String) -> Any {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                   
                    print(object)
                    return object
                } else if let object = json as? [Any] {
                   print(object)
                    return object
                } else {
                    print("JSON is invalid")
                    return ""
                }
            } else {
                print("no file")
                return ""
            }
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
    
    static func unArchiveObject(key: String) -> AnyObject? {
        guard let data = UserDefaults.standard.object(forKey: LOGIN_KEY) as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject
    }

   static func txtfeildSpacing(textfield:UITextField){
        textfield.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
    }
    static func txtfieldPlaceholderWhite(textfield:UITextField){
        textfield .setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
    }

    static func isValidEmail(_ testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
  
    static   func textAttachmentWithImage(flag:intmax_t,title: NSString,image: NSString,fontName:UIFont) -> NSMutableAttributedString {
        
        let textAttachment = NSTextAttachment()
        
        
        textAttachment.image = UIImage(named: image as String)
        
        let mid = fontName.descender + fontName.capHeight
        
        if (flag == 0)
        {
            textAttachment.bounds = CGRect(x: 0, y: fontName.descender - textAttachment.image!.size.height / 2 + mid + 2, width: textAttachment.image!.size.width, height: textAttachment.image!.size.height).integral
        }
        else
        {
            textAttachment.bounds = CGRect(x: 0, y: fontName.descender - textAttachment.image!.size.height / 2 + mid + 2 , width: textAttachment.image!.size.width, height: textAttachment.image!.size.height).integral
        }
        
        let attachmentString = NSAttributedString(attachment: textAttachment)
        let newString = NSMutableAttributedString()
        let myString = NSMutableAttributedString(string:title as String)
        
        if (flag == 2)
        {
            newString.append(myString)
            newString.append(attachmentString)
            
        }
        else
        {
            newString.append(attachmentString)
            newString.append(myString)
        }
        
        return newString
    }
   
//    static func getMultipleTextColor(text1:String,text2:String) -> NSAttributedString{
//        
//        let attrs1 = [NSAttributedStringKey.font : UIFont(name: FontName.MyriadProRegular, size: 14), NSAttributedStringKey.foregroundColor : UIColor.black]
//        
//        let attrs2 = [NSAttributedStringKey.font : UIFont(name: FontName.MyriadProRegular, size: 10), NSAttributedStringKey.foregroundColor : UIColor.lightGray]
//        
//        let attributedString1 = NSMutableAttributedString(string:text1, attributes:attrs1!)
//        
//        let attributedString2 = NSMutableAttributedString(string:text2, attributes:attrs2!)
//        
//        attributedString1.append(attributedString2)
//       
//        return attributedString1
//    }
    static func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        
        label.text = text
        label.sizeToFit()
        return label.frame.height
        
    }
    static func getMultipleFontsText(text1:String,text2:String,text3:String, text4:String) -> NSAttributedString{
        
        let attrs1 = [NSAttributedString.Key.font : AppFonts.RobotoLightFontWithSize(size: 14), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attrs2 = [NSAttributedString.Key.font : AppFonts.RobotoBoldFontWithSize(size: 14), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attrs3 = [NSAttributedString.Key.font : AppFonts.RobotoLightFontWithSize(size: 14), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attrs4 = [NSAttributedString.Key.font : AppFonts.RobotoBoldFontWithSize(size: 14), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attributedString1 = NSMutableAttributedString(string:text1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:text2, attributes:attrs2)
        
        let attributedString3 = NSMutableAttributedString(string:text3, attributes:attrs3)
        
        let attributedString4 = NSMutableAttributedString(string:text4, attributes:attrs4)
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        
        
        return attributedString1
    }
    
   
    static func getUTCDateFromTimeSpanString(dateStr : String) -> Date{
        var date = Date()
        let formate = DateFormatter()
        formate.locale = Locale(identifier: "en_US_POSIX")
        formate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formate.timeZone = TimeZone(identifier: "UTC")
        
        date = formate.date(from: dateStr)!
        
        return date
    }
    
    static func isDateGreater(serverDate: Date, appDate: Date)-> Bool {
        
        let compare = appDate.compare(serverDate)
        
        if compare == .orderedAscending {
            return true
        }else{
            return false
        }
    }
    static func getYearList() -> [String] {
        var yearList = [String]()
        let date = Date()
        let formatter  = DateFormatter()
        formatter.dateFormat = "YYYY"
        let year = formatter.string(from: date)
        for i in 0..<200{
            let currentYear = Int(year) ?? 2018
            yearList.append("\(currentYear - i)")
        }
        return yearList
    }
    static func getDayOfWeek(_ today:String) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        formatter.timeZone = TimeZone.current
        let todayDate = formatter.date(from: today) ?? Date()
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        switch weekDay {
        case 1:
            return "SUN"
        case 2:
            return "MON"
        case 3:
            return "TUE"
        case 4:
            return "WED"
        case 5:
            return "THU"
        case 6:
            return "FRI"
        case 7:
            return "SAT"
        default:
            return ""
        }
    }
    static func getStringFromDate(date:Date) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM YYYY"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    static func getStringFromDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "y-MM-dd H:m:ss.SSS"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    static func getStringWithFormateFromDate(date:Date) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY-MM-dd"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    static func  getDateFromString(string:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: string) ?? Date()
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: date)
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let finalDate = dateFormatter.date(from: dateString) ?? Date()
        return finalDate
    }
    
    static func getTimeStringFromDate(date:Date) -> String{
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mm a"
        let timeStemp = formatter.string(from: date)
        
        return timeStemp
        
    }
    static func getCurrentDate() -> Date{
        return Date()
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm a"
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        let temp = formatter.string(from: date)
//        return formatter.date(from: temp) ?? Date()
        
        //return timeStemp
        
    }
    static func getCurrentDateString() -> String{
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"//"dd MMM YYYY"
        let timeStemp = formatter.string(from: date)
        
        return timeStemp
        
    }
    static func getChatCurrentDateString() -> String{
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM yyyy hh:mm a"
        let timeStemp = formatter.string(from: date)
        
        return timeStemp
        
    }
    static func getNextDateString(date:Date,value:Int? = 1) -> String{
        let today = date
        let tomorrow = Calendar.current.date(byAdding: .day, value: value!, to: today)
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM YYYY"
        let timeStemp = formatter.string(from: tomorrow!)
        
        return timeStemp
    }
    static func getNextDateStringForDay(date:Date,value:Int? = 1) -> String{
        let today = date
        let tomorrow = Calendar.current.date(byAdding: .day, value: value!, to: today)
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dddd"
        let timeStemp = formatter.string(from: tomorrow!)
        
        return timeStemp
    }
    
    static func getFlipTransition() -> CATransition{
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType(rawValue: "flip")
        transition.subtype = CATransitionSubtype.fromLeft
        return transition
    }
    static func isCurrentDate(strDate:String) -> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let temp = formatter.date(from: strDate)
        let currentString = formatter.string(from: Date())
        let currentDate = formatter.date(from: currentString)
        if(currentDate == temp){
            return true
        }
        return false
    }
    static func getDateTimeFormatteForChat(strDate:String) -> String{
        
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        if(self.isCurrentDate(strDate: strDate)){
            return "Today"
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy HH:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let temp = formatter.date(from: strDate)
        
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = TimeZone.current
        let timeStemp = formatter.string(from: temp!)
       // let newDate = formatter.date(from: timeStemp)
        print(timeStemp)
        
        return timeStemp
    }
    static func getDayFromDateString(strDate:String) -> String{
        
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let temp = formatter.date(from: strDate)
        
        formatter.dateFormat = "dd"
        formatter.timeZone = TimeZone.current
        let timeStemp = formatter.string(from: temp!)
        // let newDate = formatter.date(from: timeStemp)
        print(timeStemp)
        
        return timeStemp
    }
    static func getMonthFromDateString(strDate:String) -> String{
        
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let temp = formatter.date(from: strDate)
        
        formatter.dateFormat = "MMM"
        formatter.timeZone = TimeZone.current
        let timeStemp = formatter.string(from: temp!)
        // let newDate = formatter.date(from: timeStemp)
        print(timeStemp)
        
        return timeStemp
    }
    static func getYearFromDateString(strDate:String) -> String{
        
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let temp = formatter.date(from: strDate)
        
        formatter.dateFormat = "yy"
        formatter.timeZone = TimeZone.current
        let timeStemp = formatter.string(from: temp!)
        // let newDate = formatter.date(from: timeStemp)
        print(timeStemp)
        
        return timeStemp
    }
    static func getTimeFromDateString(strDate:String) -> String{
        
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let temp = formatter.date(from: strDate) ?? formatter.date(from: "10:10 AM")
        
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone.current
        let timeStemp = formatter.string(from: temp!)
        // let newDate = formatter.date(from: timeStemp)
        print(timeStemp)
        
        return timeStemp
    }
    static func getOnlyDateStringForEvent(strDate:String) -> String{
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let tempDate = formatter.date(from: strDate) ?? Date()
        
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.timeZone = TimeZone.current
        let dateString = formatter.string(from: tempDate)
        return dateString
    }
    static func getDateStringForNotification(strDate:String) -> String{
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.timeZone = TimeZone.current
        let tempDate = formatter.date(from: strDate)  ?? Date()
        
        
        return self.dateTimeDifference(date: tempDate )
    }
    static func dateTimeDifference(date: Date) -> String {
        
        let date1:Date = Date() // Same you did before with timeNow variable
        let date2: Date = date
        let calender:Calendar = Calendar.current
        let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date2, to: date1)
        print(components)
        var returnString:String! = ""
        if components.day! >= 1{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            //formatter.timeZone = TimeZone.current
            let timeStemp = formatter.string(from: date)
            return timeStemp
        }else if components.hour! >= 1{
            returnString =  "Today"
        }else if components.minute! >= 1{
            returnString =  "Today"
        }else if components.second! < 60 {
            returnString = "Now"
        }
        return returnString!
    }
    static func getDateStringForChat(strDate:String) -> String{
        if(strDate.trimmingCharacters(in: .whitespaces).isEmpty){
            return ""
        }
        print("serverDate \(strDate)")
        let formatter = DateFormatter()

        formatter.dateFormat = "dd-MM-yyyy hh:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let tempDate = formatter.date(from: strDate)

        return self.getTimeDifferenceForChat(date: tempDate ?? Date())
        
       
        
       
    }
    static func getTimeDifferenceForChat(date: Date) -> String {
        
        let date1:Date = Date()
        // Same you did before with timeNow variable
        let date2: Date = date
        let calender:Calendar = Calendar.current
        let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date2, to: date1)
        print(components)
        var returnString:String! = ""
        if components.year! >= 1 {
            returnString = self.getDateStringFromDate(date: date2)
        }else if components.month! >= 1{
            returnString = self.getDateStringFromDate(date: date2)
        }else if components.day! == 1{
            returnString = self.getDateStringFromDate(date: date2)
        }else if components.day! > 1{
            returnString = self.getDateStringFromDate(date: date2)
        }else{
            if(Calendar.current.isDateInToday(date2)){
                returnString = self.getTimeFromDate(date: date2)
            }else{
                returnString = self.getDateStringFromDate(date: date2)
            }
            //if components.hour! >= 1{
        }
//            returnString = self.getTimeFromDate(date: date2)
//        }else if components.minute! >= 1{
//            returnString = self.getTimeFromDate(date: date2)
//        }else if components.second! < 60 {
//            returnString = self.getTimeFromDate(date: date2)
//        }
        return returnString!
    }
//    static func getTimeDifferenceForChat(date: Date) -> String {
//
//        let date1:Date = Date() // Same you did before with timeNow variable
//        let date2: Date = date
//        let calender:Calendar = Calendar.current
//        let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date2, to: date1)
//        print(components)
//        var returnString:String! = ""
//        if components.year! >= 1 {
//            returnString = String(describing: components.year!) + " year ago"
//        }else if components.month! >= 1{
//            returnString = String(describing: components.month!) + " month ago"
//        }else if components.day! == 1{
//            returnString = String(describing: components.day!) + " days ago"
//        }else if components.day! > 1{
//            returnString = "day ago"
//        }else if components.hour! >= 1{
//            returnString = String(describing: components.hour!) + " hour ago"
//        }else if components.minute! >= 1{
//            returnString = String(describing: components.minute!) + " min ago"
//        }else if components.second! < 60 {
//            returnString = "Just Now"
//        }
//        return returnString!
//    }
    static func isOneHourLeft(date: Date) -> Bool {
        
        let date1:Date = self.getCurrentDate() // Same you did before with timeNow variable
        let date2: Date = date
        let calender:Calendar = Calendar.current
        let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date1, to: date2)
        print(components)
        if(components.year! > 0 || components.month! > 0 || components.day! > 0 || components.hour! > 1){
            return false
        }
        if(components.hour! == 1 && components.minute! > 0){
            return false
        }else if components.hour! <= 1{
            return true
        }
        return true
    }
    static func getTimeFromDate(date:Date) -> String{
        
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone.current
        let timeStemp = formatter.string(from: date)
        print("Local \(timeStemp)")
        return timeStemp
    }
    static func getDateStringFromDate(date:Date) -> String{
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "dd MMM YYYY hh:mm a"
        formatter.timeZone = TimeZone.current
        
        let dateString = formatter.string(from: date)
        print("Local \(dateString)")
        return dateString
    }
//    static func getDateTimeFormatteForChat(strDate:String) -> String{
//
//        if(strDate.isEmpty){
//            return ""
//        }
//        let formatter = DateFormatter()
//
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        formatter.timeZone = TimeZone(abbreviation: "GMT")
//        let temp = formatter.date(from: strDate)
//
//        formatter.dateFormat = "dd-MM-yyyy h:mm a"
//        formatter.timeZone = TimeZone.current
//        let timeStemp = formatter.string(from: temp!)
//        let newDate = formatter.date(from: timeStemp)
//        print(timeStemp)
//
//        return self.dateTimeDifference(date: newDate!)
//    }
}

extension Date {
    
    /// Returns a Date with the specified days added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        var targetDay: Date
        targetDay = Calendar.current.date(byAdding: .year, value: years, to: self)!
        targetDay = Calendar.current.date(byAdding: .month, value: months, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .day, value: days, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .hour, value: hours, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .minute, value: minutes, to: targetDay)!
        targetDay = Calendar.current.date(byAdding: .second, value: seconds, to: targetDay)!
        return targetDay
    }
    
    /// Returns a Date with the specified days subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let inverseYears = -1 * years
        let inverseMonths = -1 * months
        let inverseDays = -1 * days
        let inverseHours = -1 * hours
        let inverseMinutes = -1 * minutes
        let inverseSeconds = -1 * seconds
        return add(years: inverseYears, months: inverseMonths, days: inverseDays, hours: inverseHours, minutes: inverseMinutes, seconds: inverseSeconds)
    }
    
}
extension UserDefaults {
    
    func set<T: Encodable>(codable: T, forKey key: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(codable)
            let jsonString = String(data: data, encoding: .utf8)!
            print("Saving \"\(key)\": \(jsonString)")
            self.set(jsonString, forKey: key)
        } catch {
            print("Saving \"\(key)\" failed: \(error)")
        }
    }
    
    func codable<T: Decodable>(_ codable: T.Type, forKey key: String) -> T? {
        guard let jsonString = self.string(forKey: key) else { return nil }
        guard let data = jsonString.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        print("Loading \"\(key)\": \(jsonString)")
        return try? decoder.decode(codable, from: data)
    }
}

