//
//  CaptionImageView.swift
//  CustomNotification
//
//  Created by Phi Van Tuan on 03/08/2022.
//

import Foundation
import UIKit

struct CaptionMobioImageView{
    var caption: String = ""
    var subcaption: String = ""
    var imageUrl: String = ""
    var actionUrl: String = ""
    var bgColor: String = ""
    var captionColor: String = ""
    var subcaptionColor: String = ""
}
class MobioImageView : UIView{
    var components = CaptionMobioImageView()
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var captionLabel: UILabel = {
        let captionLabel = UILabel()
        captionLabel.textAlignment = .left
        captionLabel.adjustsFontSizeToFitWidth = false
        captionLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        return captionLabel
    }()
    private var subcaptionLabel: UILabel = {
        let subcaptionLabel = UILabel()
        subcaptionLabel.textAlignment = .left
        subcaptionLabel.adjustsFontSizeToFitWidth = false
        subcaptionLabel.font = UIFont.systemFont(ofSize: 12.0)
        subcaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return subcaptionLabel
    }()
    
    init(components: CaptionMobioImageView) {
        super.init(frame: .zero)
        
        self.components = components
        setUpViews()
        setUpConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        addSubview(imageView)
        addSubview(captionLabel)
        addSubview(subcaptionLabel)
        CTUtiltiy.checkImageUrlValid(imageUrl: components.imageUrl) { [weak self] (imageData) in
            DispatchQueue.main.async {
                if imageData != nil {
                    self?.imageView.image = imageData
                    self?.activateImageViewContraints()
                }
            }
        }
        captionLabel.text = components.caption
        subcaptionLabel.text = components.subcaption
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -(CTUtiltiy.getCaptionHeight() - Constraints.kCaptionTopPadding)),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.kCaptionLeftPadding),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.kCaptionLeftPadding),
            captionLabel.heightAnchor.constraint(equalToConstant: Constraints.kCaptionHeight),
            
            subcaptionLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -(Constraints.kSubCaptionHeight + Constraints.kSubCaptionTopPadding)),
            subcaptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.kCaptionLeftPadding),
            subcaptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraints.kCaptionLeftPadding),
            subcaptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.kSubCaptionTopPadding),
            subcaptionLabel.heightAnchor.constraint(equalToConstant: Constraints.kSubCaptionHeight)
        ])
    }
    
    func activateImageViewContraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: -Constraints.kImageBorderWidth),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -Constraints.kImageBorderWidth),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constraints.kImageBorderWidth),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CTUtiltiy.getCaptionHeight())
        ])
    }
}
