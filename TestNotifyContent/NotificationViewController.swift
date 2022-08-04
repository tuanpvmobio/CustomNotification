//
//  NotificationViewController.swift
//  TestNotifyContent
//
//  Created by Phi Van Tuan on 01/08/2022.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import SwiftUI
import WebKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    var userInfo: [AnyHashable:Any]?
    let webView = WKWebView()
    let swiftUIController = UIHostingController(rootView: ListView())
    
    var contentView: UIView = UIView(frame: .zero)
    var pageControl: UIPageControl = UIPageControl(frame: .zero)
    var currentItemView: MobioImageView = MobioImageView(frame: .zero)
    var itemViews =  [MobioImageView]()
    var currentItemIndex: Int = 0
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView = UIView(frame: view.frame)
        view.addSubview(contentView)
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        print("didReceive")
        self.userInfo = notification.request.content.userInfo
        let bodyHtml = userInfo?["body_html"] as? String? ?? ""
        webView.backgroundColor = .green
        webView.isOpaque = true
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        webView.loadHTMLString(bodyHtml!, baseURL: nil)
        label.center = CGPoint(x: 00, y: 05)
        webView.center = CGPoint(x:10,y:10)
        label.textAlignment = .center
        label.text = userInfo?["title"] as? String? ?? ""
//        self.view.addSubview(webView)
        
        
        showCarousel(notification)
    }
    
    override func viewDidLayoutSubviews() {
//        webView.frame = self.view.bounds
    }
    
    override func loadView() {
        self.view = UIView(frame: .zero)
    }
    
    private func showDefaultNotify(_ notification: UNNotification){
        
    }
    
    private func showBigPicture(_ notification: UNNotification ){
        let userInfo = notification.request.content.userInfo
        let body = userInfo["body_html"]
    }
    
    private func showCarousel( _ notification: UNNotification){
       print(userInfo?["image_url"])
        if let imageUrls = userInfo?["image_url"] as? [String]{
            for(index,url) in imageUrls.enumerated(){
                CTUtiltiy.checkImageUrlValid(imageUrl: url) { [weak self] (imageData) in
                    DispatchQueue.main.async {
                        if imageData != nil {
                            let itemComponents = CaptionMobioImageView(caption: "Caption \(index)", subcaption: "Subcaption \(index)", imageUrl: url)
                            let itemView = MobioImageView(components: itemComponents)
                            self?.itemViews.append(itemView)
                        }
                        
                        if (index == imageUrls.count - 1) {
                            print("")
                            self?.setUpConstraints()
                        }
                    }
                }
            }
        }
        
        
    }
    
    func setUpConstraints( ){
        createFrameWithImage()
        
        
        currentItemView = itemViews[currentItemIndex]
        contentView.addSubview(currentItemView)
        currentItemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentItemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            currentItemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            currentItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            currentItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        if itemViews.count > 1 {
            pageControl.numberOfPages = itemViews.count
            pageControl.hidesForSinglePage = true
            self.view.addSubview(pageControl)
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pageControl.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(CTUtiltiy.getCaptionHeight() + Constraints.kPageControlViewHeight)),
                pageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                pageControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: Constraints.kPageControlViewHeight)
            ])
            
            startAutoPlay()
            
        }
    }
    
    func createFrameWithImage() {
        let viewWidth = view.frame.size.width
        var viewHeight = viewWidth + CTUtiltiy.getCaptionHeight()
        // For view in Landscape
        viewHeight = (viewWidth * (Constraints.kLandscapeMultiplier)) + CTUtiltiy.getCaptionHeight()

        let frame: CGRect = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        view.frame = frame
        contentView.frame = frame
        preferredContentSize = CGSize(width: viewWidth, height: viewHeight)
    }
    
    func moveSlider(direction: Int) {
        currentItemView.removeFromSuperview()

        currentItemIndex = currentItemIndex + direction
        if currentItemIndex >= itemViews.count {
            currentItemIndex = 0
        } else if currentItemIndex < 0 {
            currentItemIndex = itemViews.count - 1
        }

        currentItemView = itemViews[currentItemIndex]
        contentView.addSubview(currentItemView)
        currentItemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentItemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            currentItemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            currentItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            currentItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        pageControl.currentPage = currentItemIndex
//        if templateType == TemplateConstants.kTemplateManualCarousel {
//            contentView.bringSubviewToFront(nextButton)
//            contentView.bringSubviewToFront(previousButton)
//        }
    }
    
    func startAutoPlay() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showNext), userInfo: nil, repeats: true)
        }
    }
    
    @objc func showNext() {
        moveSlider(direction: 1)
    }
    

}
