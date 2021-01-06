//
//  HelloRxCocoaViewController.swift
//  MasteringRxSwift
//
//  Created by Keun young Kim on 26/08/2019.
//  Copyright © 2019 Keun young Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HelloRxCocoaViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var valueLabel: UILabel!
   
   @IBOutlet weak var tapButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()

    // button을 탭하면 label을 업데이트
    tapButton.rx.tap
        .map { "Hello, RxCocoa" }
        .bind(to: valueLabel.rx.text)
        .disposed(by: bag)
   }
}
