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
import NSObject_Rx

enum ApiError: Error {
    case badUrl
    case invalidResponse
    case failed(Int)
    case invalidData
}

// RxSwift 에서 네트워크 요청을 처리하는 세 가지 방법
// 1. Observable을 직접 생성하는 방법
// 2. RxCocoa가 제공하는 Extension 사용
// 3. Github에 공개되어있는 라이브러리 사용
class RxCocoaURLSessionViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    let list = BehaviorSubject(value: [Book]())


    override func viewDidLoad() {
        super.viewDidLoad()

        list
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, element, cell in
                cell.textLabel?.text = element.title
                cell.detailTextLabel?.text = element.desc
            }
            .disposed(by: rx.disposeBag)

        fetchBookList()
    }


    func fetchBookList() {
        // RxCocoa가 제공하는 Extension을 사용하여 개선하는 방법 2가지
        // 1. reponse 메서드 사용 : 응답을 확인하는 부분을 직접 구현하고 싶다면
        // 2. data 메서드 사용 : 응답을 확인할 때 상태코드를 확인하는 것으로 충분하다면

        let response = Observable.just(booksUrlStr)
            .map { URL(string: $0)! }
            .map { URLRequest(url: $0) }
            .flatMap { URLSession.shared.rx.data(request: $0) }
            .map(BookList.parse(data: ))
            .asDriver(onErrorJustReturn: [])
    }
}
