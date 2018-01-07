//
//  CGStruct+Extension.swift
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

extension CGPoint {
    func substract(_ fromPoint:CGPoint) -> CGPoint {
        let dx = x - fromPoint.x
        let dy = y - fromPoint.y
        return CGPoint.init(x: dx, y: dy)
    }
    
    func add(_ fromPoint:CGPoint) -> CGPoint {
        let dx = x + fromPoint.x
        let dy = y + fromPoint.y
        return CGPoint.init(x: dx, y: dy)
    }

    func getAngle(_ fromPoint:CGPoint) -> CGFloat {
        let point = substract(fromPoint)
        return atan2(point.y,point.x)
    }
}
extension CGFloat {
    var f: Float { return Float(self) }
}
extension Float {
    var cf:CGFloat { return CGFloat(self) }
}
