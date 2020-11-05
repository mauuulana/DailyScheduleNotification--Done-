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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
