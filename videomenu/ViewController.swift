//
//  ViewController.swift
//  videomenu
//
//  Created by Inpyo Hong on 2020/07/16.
//  Copyright © 2020 Inpyo Hong. All rights reserved.
//

import UIKit
import PictureInPicture

class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBtn(_ sender: Any) {
       guard let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PiP") as? UIViewController else { return }
       vc.modalPresentationStyle = .overFullScreen
       PictureInPicture.shared.present(with: vc)
    }
}

