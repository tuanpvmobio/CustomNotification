//
//  TestNotificationBuilder.swift
//  CustomNotification
//
//  Created by Phi Van Tuan on 01/08/2022.
//

import Foundation
import UserNotifications
import UserNotificationsUI


class TestNotificationBuilder {
    let delegate = TestNotifyDelegate()
    let center = UNUserNotificationCenter.current()
    
    func registerNotification(){
        center.delegate = delegate
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("Permission granted: \(granted)")
        }
    }
    
    func showNotification(){
        let data = ["alert": [
            "background_image": "https://t1.mobio.vn/static/1b99bdcf-d582-4f49-9715-1b61dfff3924/1657080303402.jpeg",
            "image_url": [
                "https://totrongnhan.com/wp-content/uploads/2021/04/San-1.png",
                "https://tinypng.com/images/social/website.jpg",
                "https://cdn.pixabay.com/photo/2022/01/11/21/48/link-6931554__340.png",
                "https://static.remove.bg/remove-bg-web/669d7b10b2296142983fac5a5243789bd1838d00/assets/start-1abfb4fe2980eabfbbaaa4365a0692539f7cd2725f324f904565a9a744f8e214.jpg"
            ],
            "content_type": "popup",
            "url_target": "",
            "body": "Chương trình nạp thẻ Viettel trúng 1 tỷ đồng",
            "body_html": "<div>Cứ chốt đơn Dealtoday thả ga vì ưu đãi hoàn tiền từ ví<span style= \("color: rgb(255, 153, 0);")> MOBIO</span> cho phép!<div><div><br><div><div>⚡ Hoàn 15K cho đơn từ 100K<div><div>⚡ Áp dụng khi sử dụng tính năng Dealtoday trên ví MOBIO<div><div>⚡ Đối tượng: Tất cả khách hàng đăng kí ví MOBIO<div><div><br><div><div>Xem chi tiết tại đây <a href=\("https:\\url.mobio.io\\JB2s9zkc") target=\"_blank\">https://mobio.io/</a><div><div><img style=\("max-width: 100%") src=\("https://t1.mobio.vn/static/1b99bdcf-d582-4f49-9715-1b61dfff3924/624bcb6d470e6e1d1b904c2a.jpg")></div>",
            "title": "Viettel khuyến mãi",
            "style": "",
            "timer": 200,
            "position": "bc"
        ]]
        
        let alert = data["alert"]
        let backgroundImage = alert?["background_image"] as? String
        let body = alert?["body"] as? String
        
        
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "custom"
        content.title = "Hello"
        content.body = "\(body ?? "")"
        
        if let userInfo = alert as? [String:Any] {
            content.userInfo = userInfo
        }
        
        if let attachment = getAttatchmentFromBitmapSource(backgroundImage, rounded: false) {
            content.attachments.append(attachment)
        }
        
        content.sound = UNNotificationSound.default
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "custom2", content: content, trigger: trigger) // Schedule the notification.
        let notificationCategory = UNNotificationCategory(identifier: "custom",
                                                          actions: [],
                                                          intentIdentifiers: [],
                                                          hiddenPreviewsBodyPlaceholder: "",
                                                          options: .customDismissAction)
        center.setNotificationCategories([notificationCategory])
        center.add(request) {
            (error) in
        }
        
    }
    
    func showNotificationBigPicture() {
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        
        
        content.body = "body"
        content.categoryIdentifier = "custom"
        content.userInfo = ["customData": "fizzbuzz"]
        
        content.sound = UNNotificationSound.default
        
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "custom", content: content, trigger: trigger) // Schedule the notification.
        let notificationCategory = UNNotificationCategory(identifier: "custom",
                                                          actions: [],
                                                          intentIdentifiers: [],
                                                          hiddenPreviewsBodyPlaceholder: "",
                                                          options: .customDismissAction)
        center.setNotificationCategories([notificationCategory])
        center.add(request) { err in
        }
        
    }
    
    func showNotifyCarousel( ){
        
    }
    
    private func getAttatchmentFromBitmapSource(_ bitmapSource:String?, rounded:Bool) -> UNNotificationAttachment? {
        
        //let dimensionLimit:CGFloat = 1038.0
        
        if !StringUtils.isNullOrEmpty(bitmapSource) {
            
            if let image:UIImage = BitmapUtils.getBitmapFromSource(bitmapPath: bitmapSource!, roundedBitpmap: rounded) {
                
                let fileManager = FileManager.default
                let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
                let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
                
                do {
                    try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
                    let imageFileIdentifier = bitmapSource!.md5 + ".png"
                    let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
                    
                    // JPEG is more memory efficient, but switches trasparency by white color
                    let imageData = image.pngData()//.jpegData(compressionQuality: 0.9)//
                    try imageData?.write(to: fileURL)
                    
                    let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: nil)
                    return imageAttachment
                    
                } catch {
                    print("error " + error.localizedDescription)
                }
            }
        }
        return nil
    }
}
