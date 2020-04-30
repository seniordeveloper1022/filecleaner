//
//  ResultPreviewViewController.swift
//  ZeroDuplicate
//
//  Created by Waqas Ahmad on 15/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit


class ResultPreviewViewController: UIViewController,TopBarDelegate {
    

  
    @IBOutlet weak var collectionView:UICollectionView?
    
    var index:Int = 0
    var imagesList:[ImageViewModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
//    ca-app-pub-4964284666734851~6096651948
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.lblTitle.text = "Results"
            container.delegate = self
            container.btnEdit.isHidden = true
            container.addBackIcon(isAddBack: true)
        }
        GCD.async(.Main, delay: 0.3) {
            if(self.index > 0){
                self.collectionView?.scrollToItem(at: IndexPath.init(row: self.index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
            }
        }
        
    }
    func actionCallBackMoveBack() {
        self.navigationController?.popViewController(animated: true)
       
    }


}

extension ResultPreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let _ = self.imagesList{
            return 1
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesList!.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultPreviewCollectionViewCell", for: indexPath) as! ResultPreviewCollectionViewCell
        cell.configure(image: self.imagesList![indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Index \(indexPath.row)")
    }
}
