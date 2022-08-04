//
//  BitmapUtils.swift
//  CustomNotification
//
//  Created by Phi Van Tuan on 02/08/2022.
//

import Foundation
import UIKit

class BitmapUtils{
    public static func getBitmapFromSource(bitmapPath:String?, roundedBitpmap:Bool) -> UIImage? {
        if(bitmapPath?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true) {
            return nil
            
        }
        var resultedImage = getBitmapFromUrl(bitmapPath ?? "")
        
        if(resultedImage != nil && roundedBitpmap){
            resultedImage = roundUiImage(resultedImage!)
        }
        
        return resultedImage
    }
    
    private static func cleanMediaPath(_ mediaPath:String?) -> String? {
         if(mediaPath != nil){
             var mediaPath = mediaPath
             
            if(mediaPath!.matches("^https?:\\/\\/")){
                 return mediaPath
             }
             else
             if(mediaPath!.matches("^(asset:\\/\\/)(.*)")){
                 if mediaPath!.replaceRegex("^(asset:\\/\\/)(.*)", replaceWith: "$2") {
                     return mediaPath
                 }
             }
             else
             if(mediaPath!.matches("^(file:\\/\\/)(.*)")){
                 if mediaPath!.replaceRegex("^(file:\\/\\/)(.*)", replaceWith: "$2") {
                     return mediaPath
                 }
             }
             else
             if(mediaPath!.matches("^(resource:\\/\\/)(.*)")){
                 if mediaPath!.replaceRegex("^(resource:\\/\\/)(.*)", replaceWith: "$2") {
                     return mediaPath
                 }
             }
             
         }
         return nil
    }
    
    public static func getBitmapFromUrl(_ bitmapUri:String) -> UIImage? {
        let bitmapUri:String? = BitmapUtils.cleanMediaPath(bitmapUri)
        
        if !StringUtils.isNullOrEmpty(bitmapUri), let url = URL(string: bitmapUri!) {

            do {
                
                let imageData = try Data(contentsOf: url)
                
                // This is necessary to protect the target executions
                // from EXC_RESOURCE_RESOURCE_TYPE_MEMORY fatal exception
            
                return UIImage(data: imageData)
                
            } catch let error {
                print("Url error: \(error)")
            }
        }
        
        return nil
    }
    
    public static func roundUiImage(_ image:UIImage) -> UIImage? {
        let rect = CGRect(origin: .zero, size: image.size)
        let format = image.imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: image.size, format: format).image{ _ in
            UIBezierPath(ovalIn: rect).addClip()
            image.draw(in: rect)
        }
    }
}
