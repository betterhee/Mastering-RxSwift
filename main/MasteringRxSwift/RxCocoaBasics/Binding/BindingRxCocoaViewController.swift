//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift
import RxCocoa

class BindingRxCocoaViewController: UIViewController {
   
   @IBOutlet weak var valueLabel: UILabel!
   
   @IBOutlet weak var valueField: UITextField!
   
   let disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      valueLabel.text = ""
      valueField.becomeFirstResponder()

    // Binder Type:
    // - UI Binding에 사용하는 특별한 Observer

    // Binder의 특징과 장점:
    // - Error 이벤트를 받지 않음
    // - 바인딩에 성공하면 UI 업데이트 (메인스레드에서 실행되도록 보장)
    // - Cocoa 보다 코드가 단순하다
    // - Cocoa delegate 패턴과 달리 코드만으로 실행 흐름을 쉽게 파악 가능

    // UI 업데이트 코드이므로 반드시 메인스레드에서 실행되도록 해야함
    // 1. GCD 사용하는 방법
    valueField.rx.text
        .subscribe(onNext: { [weak self] str in
            DispatchQueue.main.async {
                self?.valueLabel.text = str
            }
        })
        .disposed(by: disposeBag)

    // 2. 조금더 Rx답게 observeOn을 사용하는 방법
    valueField.rx.text
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] str in
            self?.valueLabel.text = str
        })
        .disposed(by: disposeBag)

    // 3. RxCocoa가 제공하는 bind 메소드를 사용하는 방법
    // - 옵저버블이 방출한 이벤트를 옵저버에 전달
    // - 바인더는 바인딩이 메인스레드에서 실행하도록 보장한다~
    valueField.rx.text
        .bind(to: valueLabel.rx.text)
        .disposed(by: disposeBag)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      valueField.resignFirstResponder()
   }
}
