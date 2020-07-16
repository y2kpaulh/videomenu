//
//  BroadcastViewController.swift
//  PictureInPicture
//
//  Created by Koji Murata on 2017/07/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PictureInPicture
import RxDataSources
import IQKeyboardManagerSwift

final class BroadcastViewController: UIViewController {
//  var rxDataSource: RxCollectionViewSectionedReloadDataSource<BroadcastSection>!
//  private var subject: BehaviorRelay<[BroadcastSection]> = BehaviorRelay(value: [])

  var collectionView: UICollectionView?
  var collectionLayout: HorizontalCollectionViewLayout = HorizontalCollectionViewLayout()
  let disposeBag = DisposeBag()
    
  let chatView = ChatRoomViewController()

    /// Required for the `MessageInputBar` to be visible
    override var canBecomeFirstResponder: Bool {
      return chatView.canBecomeFirstResponder
    }

    /// Required for the `MessageInputBar` to be visible
    override var inputAccessoryView: UIView? {
      return chatView.inputAccessoryView
    }

    
  override func viewDidLoad() {
    super.viewDidLoad()
        
    self.navigationController?.navigationBar.isHidden = true
        
    self.view.backgroundColor = .clear
            
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionLayout)
    collectionView?.delegate = nil
    collectionView?.dataSource = nil
    
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
    // configChatView()
    //bindCollectionView()
  }
    
//  func bindCollectionView() {
//    let cities = Observable.of(["Lisbon", "Copenhagen", "London", "Madrid", "Vienna"])
//
//      cities.bind(to: collectionView!.rx.items) { (collectionView: UICollectionView, index: Int, element: String) in
//      let cell = UICollectionViewCell(frame: self.view.bounds)
//      return cell
//      }.disposed(by: disposeBag)
//
//      collectionView!.rx.modelSelected(String.self)
//         .subscribe(onNext: { model in
//             print("\(model) was selected")
//         })
//         .disposed(by: disposeBag)
//  }

    func configChatView() {
      chatView.willMove(toParent: self)
      addChild(chatView)
      view.addSubview(chatView.view)
      chatView.didMove(toParent: self)
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

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      //채팅창 화면 상단 하단 gradation
      let gradient = CAGradientLayer()
      gradient.frame = chatView.view.bounds
      gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
      gradient.locations = [0, 0.1, 0.8, 0.9, 1]

      chatView.view.layer.mask = gradient
      chatView.view.backgroundColor = .clear
      chatView.messageInputBar.backgroundView.backgroundColor = .clear
      chatView.inputAccessoryView?.backgroundColor = .clear

      // 채팅창 화면 사이즈 및 위치
      chatView.view.frame = CGRect(x: 0, y: 140, width: view.bounds.width, height: view.bounds.height - 200)
    }
}

extension BroadcastViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as? HorizontalCollectionViewCell else {
        return UICollectionViewCell()
    }
    
    cell.layoutIfNeeded()
    
    if indexPath.row == 0 {
        cell.configPlayer(url: "http://wowtv.xst.kinxcdn.com/wowtv/livestream/playlist.m3u8")
    }
    else{
        cell.configPlayer(url: "http://epiens.xst.kinxcdn.com/epiens/test1/playlist.m3u8")
    }
    
    chatView.willMove(toParent: self)
    addChild(chatView)
    cell.addSubview(chatView.view)
    chatView.didMove(toParent: self)
    
    return cell
  }
}
