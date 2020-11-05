//
//  NotificationHelper.swift
//  Daily Schedule Notification
//
//  Created by Maul on 05/11/20.
//

import Foundation
import UserNotifications

class NotificationHelper {
    
    //MARK: - Permission Notification
    func requestNotificationPermission() -> Void {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .announcement]) { granted, error in
            if granted == true && error == nil {
                 
            }
        }
    }
    
    //MARK: - Scheduled Notification
    func addScheduledNotification(identifier: String, title: String, body: String, hour: Int, minute: Int) -> Void {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = hour
        dateComponents.minute = minute
           
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else { return }
            print("Scheduled Notification Success")
        }
    }
    
    //MARK: - Pending Notification
    func cancelNotification(identifierName: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
           var identifiers: [String] = []
           for notification:UNNotificationRequest in notificationRequests {
               if notification.identifier == identifierName {
                  identifiers.append(notification.identifier)
               }
           }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            print("Cancel")
        }
    }
}
