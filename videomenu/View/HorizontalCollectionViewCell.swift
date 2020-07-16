//
//  HorizontalCollectionViewCell.swift
//  HorizontalCollectionView
//
//  Created by Inpyo Hong on 2020/07/15.
//  Copyright © 2020 Inpyo Hong. All rights reserved.
//

import UIKit
import CoreMedia
import AVFoundation
import AVKit
import RxSwift
import RxCocoa

class HorizontalCollectionViewCell: UICollectionViewCell {
    var url: String = ""

    @IBOutlet weak var playerView: VersaPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configPlayer(url: String) {
      if let _url = URL.init(string: url) {
        let item = VersaPlayerItem(url: _url)
        playerView.player.rate = 1
        //playerView.player.automaticallyWaitsToMinimizeStalling = false
        playerView.set(item: item)
      }

      playerView.layer.backgroundColor = UIColor.black.cgColor
      playerView.playbackDelegate = self
      playerView.renderingView.playerLayer.videoGravity = .resizeAspectFill
      playerView.isUserInteractionEnabled = false
    }
}

extension HorizontalCollectionViewCell: VersaPlayerPlaybackDelegate {
  func playbackItemReady(player: VersaPlayer, item: VersaPlayerItem?) {
    print(#function)
  }

  func playbackRateTimeChanged(player: VersaPlayer, stallTime: CFTimeInterval) {
    DispatchQueue.main.async {
      //self.stallTimeLabel.text = String(format: "Loading: %0.2f sec", stallTime)
    }
  }

  func timeDidChange(player: VersaPlayer, to time: CMTime) {
    //    guard let currentItem = player.currentItem else { return }
    //    guard let accessLog = currentItem.accessLog() else { return }
    //
    //    if accessLog.events.count > 0 {
    //      let event = accessLog.events[0]
    //      DispatchQueue.main.async {
    //        self.playbackType = event.playbackType!
    //      }
    //    }
    //
    //    durationTime = CMTimeGetSeconds((currentItem.asset.duration))
    //    playbackTime = CMTimeGetSeconds(player.currentTime())
    //
    //    if playbackType == "LIVE" {
    //      guard let livePosition = currentItem.seekableTimeRanges.last as? CMTimeRange else {
    //        return
    //      }
    //
    //      let livePositionStartSecond = CMTimeGetSeconds(livePosition.start)
    //      let livePositionEndSecond = CMTimeGetSeconds(livePosition.end)
    //
    //      storageController.save(Log(msg: "livePositionStartSecond:\(livePositionStartSecond) livePositionEndSecond:\(livePositionEndSecond)\n"))
    //    } else {
    //      guard let timeRange = currentItem.loadedTimeRanges.first?.timeRangeValue else { return }
    //      loadedTime = CMTimeGetSeconds(timeRange.duration)
    //
    //      guard let seekPosition = currentItem.seekableTimeRanges.last as? CMTimeRange else {
    //        return
    //      }
    //
    //      let seekPositionStartSecond = CMTimeGetSeconds(seekPosition.start)
    //      let seekPositionEndSecond = CMTimeGetSeconds(seekPosition.end)
    //
    //      storageController.save(Log(msg: "seekPositionStartSecond:\(seekPositionStartSecond) seekPositionEndSecond: \(seekPositionEndSecond)\n"))
    //    }
  }

  func playbackDidFailed(with error: VersaPlayerPlaybackError) {
    print(#function, "error occured:", error)
//    storageController.save(Log(msg: "\(storageController.currentTime()) \(#function) error occured: \(error)\n"))
//
//    let alert =  UIAlertController(title: "AVPlayer Error", message: "\(error)", preferredStyle: .alert)
//    let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) in
//      self.dismiss(animated: true, completion: nil)
//    })
//
//    alert.addAction(ok)
//    self.present(alert, animated: true, completion: {
//      self.playerView.controls?.hideBuffering()
//    })

    //    switch error {
    //    case .notFound:
    //        break
    //
    //    default:
    //      break
    //    }
  }

  func startBuffering(player: VersaPlayer) {
    print(#function)
  }

  // isPlaybackLikelyToKeepUp == true
  func endBuffering(player: VersaPlayer) {
    print("AVPlayerItem.isPlaybackLikelyToKeepUp == true")
    print(#function)
  }

  func playbackFailInfo(with error: NSError, type: VersaPlayerPlaybackError) {
    print(#function, error, type)
  }

  func playbackNewErrorLogEntry(with error: AVPlayerItemErrorLog) {
    print(#function, "error occured:", error.events)

//    for errLog in error.events {
//      print("AVPlayerItem Error Log", errLog.errorStatusCode, String(errLog.errorComment!))
//      if errLog.errorStatusCode == -12884 && !diplayErrorPopup {
//        diplayErrorPopup = true
//
//        DispatchQueue.main.async {
//          let alert =  UIAlertController(title: "AVPlayerItem Error Log", message: String(errLog.errorComment!), preferredStyle: .alert)
//          let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) in
//            self.diplayErrorPopup = false
//            self.dismiss(animated: true, completion: nil)
//          })
//
//          alert.addAction(ok)
//          self.present(alert, animated: true, completion: nil)
//        }
//      }
//    }
  }

  func playbackStalled(with item: AVPlayerItem) {
    print(#function, item.asset)
  }

  func playbackDidEnd(player: VersaPlayer) {
    print(#function)
  }
}
