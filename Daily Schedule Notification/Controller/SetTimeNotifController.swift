//
//  ViewController.swift
//  Daily Schedule Notification
//
//  Created by Maul on 05/11/20.
//

import UIKit

class SetTimeNotifController: UIViewController, ProtocolTimeNotif {

    @IBOutlet weak var pickerTime: UIDatePicker!
    
    var notification = NotificationHelper()
    var settingNotif: SettingNotificationController?
    
    var minute: Int?
    var hour: Int?
    var timeSelected: String?
    var arrayTimes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notification.requestNotificationPermission()
    }
    
    // When select time to separate hours and minutse, then case the hour on device when using not 24 hours to force the hours result using 24 hours format
    func selectPickerTime(picker: UIDatePicker) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateSelect = dateFormatter.string(from: picker.date)
        
        let splitAMPM = dateSelect.split(separator: " ")  //Split time with status AM/PM
        let timeFromSplit = splitAMPM[0]  //pick the time only
        
        //Split the time on hour componenent and minute component
        let timeComponentSplit = timeFromSplit.split(separator: ":")
        
        let hourSplit = timeComponentSplit[0]  //hour component based on picker
        let hoursCalculate = Int(hourSplit)! + 12 // hour component when using AM/PM and the hour is PM need to calculate with 12
        
        let minutesSplit = timeComponentSplit[1] //minutes component based on picker
        
        //Detect time have AM/PM or not
        var hours = ""
        if splitAMPM.count == 2 && splitAMPM[1] == "PM" {
            hours = String(hoursCalculate)
        } else {
            hours = String(hourSplit)
        }
        
        let minutes = String(minutesSplit)
        let timesSelected = dateSelect
        
        let array = [hours, minutes, timesSelected]
        
        return array
    }
    
    //Pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSettingNotif" {
            settingNotif = segue.destination as? SettingNotificationController
            settingNotif?.protocolTime = self
        }
    }
    
    @IBAction func pickerChange(_ sender: UIDatePicker) {
        arrayTimes = selectPickerTime(picker: pickerTime)
        hour = Int(arrayTimes[0])
        minute = Int(arrayTimes[1])
        timeSelected = arrayTimes[2]
    }

    @IBAction func nextButton(_ sender: UIButton) {
        //Set Notification
        notification.addScheduledNotification(identifier: "dailyReminder", title: "Daily Reminder", body: "Coba-Coba", hour: hour!, minute: minute!)
        
        performSegue(withIdentifier: "toSettingNotif", sender: nil)
    }
}

protocol ProtocolTimeNotif {
    func selectPickerTime(picker: UIDatePicker) -> [String]
    var timeSelected: String? {get set}
}

