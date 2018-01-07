//
//  TranslationViewController.swift
//  RxGesturePlayGarden
//
//  Created by ming on 2018/01/06.
//  Copyright (c) Rimh(Ming)[https://github.com/rimh/]
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import RxSwift
import RxGesture

class TranslationViewController: UIViewController {

    @IBOutlet weak var container:UIView!
    let disposeBag = DisposeBag()
    var previousTranslatedPoint:(CGPoint) = CGPoint.zero // to prevent a problem in touch and object related position in next round
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTranslateObserver()
    }
    
    func initTranslateObserver(){
        let observer = self.container.rx.panGesture().share(replay: 1)
        observer
            .when(.changed)
            .asTranslation(in: .view)
            .map({ [unowned self] in
                $0.translation.add(self.previousTranslatedPoint)
            })
            .subscribe(onNext:{ [unowned self] translation in
                self.container.transform = CGAffineTransform(translationX:translation.x, y: translation.y)
            }).disposed(by: disposeBag)
        
        observer
            .when(.ended)
            .asTranslation()
            .subscribe(onNext: { [unowned self] _ in
                self.previousTranslatedPoint = CGPoint.init(x: self.container.transform.tx, y:self.container.transform.ty)
            })
            .disposed(by: disposeBag)
        
    }


}

