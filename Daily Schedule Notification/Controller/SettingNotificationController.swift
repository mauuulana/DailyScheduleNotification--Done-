//
//  SettingNotificationController.swift
//  Daily Schedule Notification
//
//  Created by Maul on 05/11/20.
//

import UIKit

class SettingNotificationController: UIViewController {
    
    var pickerChangeTime = UIDatePicker()
    @IBOutlet weak var switcherNotif: UISwitch!
    @IBOutlet weak var tapChangeTimeNotif: UITextField!
    @IBOutlet weak var labelTime: UILabel!
    
    var protocolTime: ProtocolTimeNotif?
    var notification = NotificationHelper()
    
    var timeNotif: String?
    var hour: Int?
    var minute: Int?
    var arrayTimes: [String] = []
    var stateOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switcherNotif.setOn(true, animated: false)
        timeNotif = protocolTime?.timeSelected
        labelTime.text = timeNotif
        showPicker()
    }
    
    //MARK: - Picker Time
    func showPicker() {
        pickerChangeTime = UIDatePicker(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
        pickerChangeTime.locale = NSLocale(localeIdentifier: "en_GB") as Locale

        pickerChangeTime.datePickerMode = .time
        if #available(iOS 13.4, *) {
            pickerChangeTime.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(named: "MainColor")
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePickerTimes))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.date(from: timeNotif!)
        pickerChangeTime.date = time!
        
        pickerChanged()
        print("\(hour ?? 0)\(minute ?? 0)\(timeNotif ?? "00:00")")

        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        tapChangeTimeNotif.inputView = pickerChangeTime
        tapChangeTimeNotif.inputAccessoryView = toolBar

    }
    
    func pickerChanged() {
        arrayTimes = (protocolTime?.selectPickerTime(picker: pickerChangeTime))!
        hour = Int(arrayTimes[0])
        minute = Int(arrayTimes[1])
        timeNotif = arrayTimes[2]
    }
    
    @objc func donePickerTimes() {
        pickerChanged()
        print("\(hour ?? 0)\(minute ?? 0)\(timeNotif ?? "00:00")")
        checkState()
        tapChangeTimeNotif.resignFirstResponder()
        labelTime.text = timeNotif
    }
    
    @IBAction func switcherChanged(_ sender: UISwitch) {
        if switcherNotif.isOn == true {
            stateOn = true
            switcherNotif.setOn(true, animated: true)
            checkState()
        } else {
            stateOn = false
            switcherNotif.setOn(false, animated: true)
            checkState()
        }
    }
    
    func checkState() {
        if stateOn == true {
            notification.cancelNotification(identifierName: "dailyReminder")
            
            notification.addScheduledNotification(identifier: "dailyReminder", title: "Daily Reminder", body: "Coba-Coba", hour: hour ?? 0, minute: minute ?? 0)
        } else {
            notification.cancelNotification(identifierName: "dailyReminder")
        }
    }
}
