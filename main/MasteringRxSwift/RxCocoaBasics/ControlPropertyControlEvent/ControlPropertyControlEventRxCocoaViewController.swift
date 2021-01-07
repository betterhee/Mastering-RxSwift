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
// RxCocoa Traits
// - UI에 특화된 옵저버블. 모든 작업은 메인 스케쥴러(메인 스레드)에서 실행됨. UI 업데이트 코드를 작성할 때 스케쥴러를 직접 지정할 필요 없음.
// - 옵저버블이기때문에 UI 바인딩에서 데이터 생성자 역할을 수행 (Binder와 반대)
//
// - 옵저버블 시퀀스가 Error 이벤트로 인해 종료되면 UI는 더이상 업데이트 되지않음
// - 하지만 Trait는 Error 이벤트를 전달하지 않으므로 UI가 항상 올바른 스레드에서 업데이트되는 것을 보장한다
//
// - 옵저버블을 구독하면 기본적으로 새로운 시퀀스로 시작
// - Trait도 옵저버블이지만 새로운 시퀀스가 시작되지는 않고, Trait를 구독하는 모든 구독자는 동일한 시퀀스를 공유한다. = 일반 옵저버블에서 share 연산자를 사용하는 것과 동일한 방식으로 동작
//
// - RxCocoa를 사용할 때 Trait가 필수는 아니지만, 적극적으로 활용하는 것이 좋다.
// - Trait를 사용하지 않고 subscribe 메소드를 사용해도 문제 없지만 코드가 지저분해지고, UI 코드가 잘못된 스레드에서 사용될 가능성이 높아짐

// RxCocoa에서는 4가지 종류의 Trait를 제공
// - ControlProperty
// - ControlEvent
// - Driver
// - Signal

class ControlPropertyControlEventRxCocoaViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var colorView: UIView!
   
   @IBOutlet weak var redSlider: UISlider!
   @IBOutlet weak var greenSlider: UISlider!
   @IBOutlet weak var blueSlider: UISlider!
   
   @IBOutlet weak var redComponentLabel: UILabel!
   @IBOutlet weak var greenComponentLabel: UILabel!
   @IBOutlet weak var blueComponentLabel: UILabel!
   
   @IBOutlet weak var resetButton: UIButton!
   
   private func updateComponentLabel() {
      redComponentLabel.text = "\(Int(redSlider.value))"
      greenComponentLabel.text = "\(Int(greenSlider.value))"
      blueComponentLabel.text = "\(Int(blueSlider.value))"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}
