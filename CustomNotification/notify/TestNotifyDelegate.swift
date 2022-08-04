//
//  TestNotifyDelegate.swift
//  CustomNotification
//
//  Created by Phi Van Tuan on 01/08/2022.
//

import Foundation
import UserNotifications

class TestNotifyDelegate : NSObject,UNUserNotificationCenterDelegate{
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let request = notification.request
        let content = request.content
        let title = content.title
        let body = content.body
        print("------- debug ------- willPresent ------ title = ", title)

        let userInfo = content.userInfo
        
        completionHandler([.banner, .list, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let request = notification.request
        let content = request.content
        let title = content.title
        let body = content.body
        print("------- debug ------- didReceive ------ title = ", title)
        completionHandler()
    }
}
