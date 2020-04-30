//
//  ImageViewModel.swift
//  ZeroDuplicate
//
//  Created by Ghafar Tanveer on 26/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import Foundation
import Photos

class ImageViewModel {
    
    
    var positiveCoeff:[TWaveletPoint] 
    var negativeCoeff:[TWaveletPoint]
    var path:String
    var width:String
    var height:String
    var mimeType:String
    var size: Int
    var similarTo:String
    var similarity:Double
    var isOrignal:Bool
    var creationDate:String
    var location:CLLocation
    var cameraName:String
    var cameraAperture:String
    var flash:String
    var cameraISO:String
    var cameraFocalLength:String
    
    var modifiedDate:String
    var duration:String
    var isFavourite:Bool
    var isHidden:Bool
    var image:UIImage
    var asset:PHAsset
    var isDeleted: Bool
    var isSelected:Bool
    var fetchedImage:UIImage?
    
    
    init() {
        self.creationDate = ""
        self.width = ""
        self.height = ""
        self.modifiedDate = ""
        self.location = CLLocation(latitude: 0.0, longitude: 0.0)
        self.duration = ""
        self.isFavourite = false
        self.isHidden = false
        self.path = ""
        self.image = UIImage()
        self.fetchedImage = nil
        self.positiveCoeff = [TWaveletPoint](repeating: TWaveletPoint(), count: 200)
        self.negativeCoeff = [TWaveletPoint](repeating: TWaveletPoint(), count: 200)
        self.mimeType = ""
        self.similarTo = ""
        self.similarity = 0.0
        self.isOrignal = false
        self.cameraName = ""
        self.cameraISO = ""
        self.cameraAperture = ""
        self.flash = ""
        self.cameraFocalLength = ""
        self.size = 0
        self.isDeleted = false
        self.asset = PHAsset()
        self.isSelected = false
    }
    
    convenience init(asset:PHAsset) {
        self.init()
        self.creationDate = Utilities.getStringFromDate(date: asset.creationDate ?? Date())
        self.modifiedDate = Utilities.getStringFromDate(date: asset.modificationDate ?? Date())
        self.location = asset.location ?? CLLocation(latitude: 0.0, longitude: 0.0)
        self.width = "\(asset.pixelWidth)"
        self.height = "\(asset.pixelHeight)"
        self.isFavourite = asset.isFavorite
        self.isHidden = asset.isHidden
        self.asset = asset
    }
    
    
    func setSimilarTo(similarTo:String)  {
        self.similarTo = similarTo
        if(self.path == similarTo){
            self.isOrignal = true
        }
    }
    
    
   
}
extension PHAsset {
    
    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            
            
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
}
