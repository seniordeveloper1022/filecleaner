//
//  ResultPreviewCollectionViewCell.swift
//  ZeroDuplicate
//
//  Created by Rapidzz Macbook on 09/04/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit

class ResultPreviewCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var lblSimilarity : UILabel!
    @IBOutlet weak var imgFile : UIImageView!
    @IBOutlet weak var lblFileName : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblSize : UILabel!
    @IBOutlet weak var lblPath : UILabel!
    @IBOutlet weak var lblResolution : UILabel!
   
    @IBOutlet weak var lblOrignal : UILabel!
    @IBOutlet weak var viewBlackTransparent : UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image : ImageViewModel){
        if(image.isOrignal){
            self.lblOrignal?.text = ""
            self.lblSimilarity?.text = "Original"
            self.viewBlackTransparent.isHidden = true
        }else{
            self.lblSimilarity?.text = "IMAGE SIMILARITY \(Int(image.similarity))% match"
            self.lblOrignal?.text = "\(Int(image.similarity))% match"
             self.viewBlackTransparent.isHidden = true
        }
        self.lblFileName.text = image.cameraName
        self.lblDate.text = "Created: " + image.creationDate
        self.lblResolution.text = "Size: \(image.width) X \(image.height)"
        self.lblPath.text = "Path: " + image.path
        self.imgFile.fetchImage(asset: image.asset, contentMode: .aspectFit, targetSize: self.imgFile.frame.size,imageVM:image)
    }
    
}
