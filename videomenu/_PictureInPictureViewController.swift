//
//  PictureInPictureViewController.swift
//  PictureInPicture
//
//  Created by Koji Murata on 2017/07/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import PictureInPicture

final class PictureInPictureViewController: UIViewController {

  var collectionView: UICollectionView?
  var collectionLayout: HorizontalCollectionViewLayout = HorizontalCollectionViewLayout()
 
  override func viewDidLoad() {
    super.viewDidLoad()
        
    self.navigationController?.navigationBar.isHidden = true
        
    self.view.backgroundColor = .clear
        
    let collectionFrame = self.view.bounds
        
    self.collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: collectionLayout)
        
    collectionView?.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CELL")
    collectionView?.backgroundColor     = self.view.backgroundColor
    collectionView?.dataSource          = self
    collectionView?.isPagingEnabled     = false
    collectionView?.contentInset        = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionView?.layer.cornerRadius  = 8
    
    collectionLayout.scrollDirection    = .horizontal
    collectionLayout.itemSize           = self.view.frame.size
    collectionLayout.minimumLineSpacing = 0

    self.view.addSubview(collectionView!)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("willDisappear")
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print("didDisappear")
  }
  
  deinit {
    print("deinitted")
  }
    
     
  @IBAction private func dismiss() {
    PictureInPicture.shared.dismiss(animation: true)
  }
    
  @IBAction private func makeSmaller() {
    PictureInPicture.shared.makeSmaller()
  }

}

extension PictureInPictureViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as? HorizontalCollectionViewCell else {
        return UICollectionViewCell()
    }
    
    if indexPath.row == 0 {
        cell.backgroundColor = .red
    }
    else if indexPath.row == 1 {
        cell.backgroundColor = .blue
    }
    else {
        cell.backgroundColor = .green
    }
    
    return cell
  }
}
