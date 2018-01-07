//
//  RotationViewController.swift
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

class RotationViewController: UIViewController {
    
    @IBOutlet weak var container:UIView!
    let disposeBag = DisposeBag()
    
    var deltaRadian:CGFloat = 0.0 // to prevent to flipping if the new touch position is in the opposite direction from a last time

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initRotateObserver()
    }
    
    func initRotateObserver(){
        
        let observer = self.view.rx.panGesture().share(replay: 1)
        observer
            .when(.began)
            .asLocation(in: .view)
            .subscribe(onNext: { [unowned self] location in
                let containerAngle = atan2f(self.container.transform.b.f, self.container.transform.a.f).cf
                let angleFromLocation = location.getAngle(self.container.center)
                self.deltaRadian = containerAngle - angleFromLocation
            }).disposed(by: disposeBag)
        
        observer
            .when(.changed)
            .asLocation(in: .view)
            .subscribe(onNext: { [unowned self] location in
                let angle = location.getAngle(self.container.center)
                let rot = self.deltaRadian + angle
                self.container.transform = CGAffineTransform(rotationAngle: rot)
            })
            .disposed(by: disposeBag)
        
    }
}

