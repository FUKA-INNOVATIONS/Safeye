//
//  NotificationService.swift
//  Safeye
//
//  Created by Safeye team on 13.4.2022.
//

/*
    Service which handles the notifications that will be sent to the user. Handles asking the user
    to enable notifications on their device. Also creates the notifications that will be sent to
    the users.
 */

import Foundation
import UserNotifications

final class NotificationService: ObservableObject {
    static let shared = NotificationService() ;  private init() {}
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    
    
    func reloadLocalNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    
    
    func createLocalNotification(title: String, body: String, completion: @escaping (Error?) -> Void) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .defaultCritical
        notificationContent.body = body
        notificationContent.subtitle = "This is emergency situation!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    
    
}
