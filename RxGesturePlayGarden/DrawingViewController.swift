//
//  DrawingViewController.swift
//  RxGesturePlayGarden
//
//  Created by ming on 2018/01/07.
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

class DrawingViewController: UIViewController {
    @IBOutlet weak var container:UIImageView!
    let disposeBag = DisposeBag()
    var startPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initPanObserver()
        self.initLongPressedObserver()
    }
    
    // to draw
    func initPanObserver(){
        let observer = self.container.rx.panGesture().share(replay: 1)
        observer
            .when(.began)
            .asLocation()
            .subscribe(onNext: { [unowned self] location in
                self.startPoint = location
            }).disposed(by: self.disposeBag)
        observer
            .when(.changed)
            .asLocation()
            .subscribe(onNext: { [unowned self] location in
                self.drawLine(fromPoint: self.startPoint, toPoint: location)
                self.startPoint = location
            }).disposed(by: self.disposeBag)
    }
    
    // to erase all
    func initLongPressedObserver(){
        let observer = self.container.rx.longPressGesture().share(replay: 1)
        observer
            .when(.began)
            .subscribe(onNext: {[unowned self] _ in
                self.container.image = nil
            }).disposed(by: self.disposeBag)
    }
    
    func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(container.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        self.container.image?.draw(in: CGRect.init(origin: CGPoint.zero, size: container.frame.size))
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        context.setLineWidth(5)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setBlendMode(.normal)
        context.strokePath()
        self.container.image = UIGraphicsGetImageFromCurrentImageContext()
        self.container.alpha = 1.0
    }
}


