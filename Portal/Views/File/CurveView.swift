//
//  CurveView.swift
//  Portal
//
//  Created by Allen on 8/29/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class CurveView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let cubicPath = CGPathCreateMutable()
        CGPathMoveToPoint(cubicPath, nil, 0, 0)
        
        var prevDx: CGFloat = 0.0
        var prevDy: CGFloat = 0.0
        var curDx: CGFloat = 0.0
        var curDy: CGFloat = 0.0
        
        let points = [(0,200),(100,100),(200,300),(300,200)]//,(0,200),(100,100),(200,300),(300,100)]
        var prevPrev = points[0]
        var prev = points[0]
        var cur = points[0]
        var next = points[1]
        let intensity = CGFloat(0.2)
        let phaseY = 1
        
        CGPathMoveToPoint(cubicPath, nil, CGFloat(prevPrev.0), CGFloat(prevPrev.1))
        
        for index in 1.stride(to: points.count, by: 1) {
            prevPrev = prev
            prev = cur
            cur = next
            
            if index + 1 < points.count {
                next = points[index + 1]
            }
            else {
                next = cur
            }
            
            prevDx = CGFloat(cur.0 - prevPrev.0) * intensity
            prevDy = CGFloat(cur.1 - prevPrev.1) * intensity
            curDx = CGFloat(next.0 - prev.0) * intensity
            curDy = CGFloat(next.1 - prev.1) * intensity
            
            CGPathAddCurveToPoint(cubicPath, nil,
                                  CGFloat(prev.0) + prevDx,
                                  (CGFloat(prev.1) + prevDy) * CGFloat(phaseY),
                                  CGFloat(cur.0) - curDx,
                                  (CGFloat(cur.1) - curDy) * CGFloat(phaseY),
                                  CGFloat(cur.0),
                                  CGFloat(cur.1) * CGFloat(phaseY))
        }
        

        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        CGContextAddPath(context, cubicPath)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextStrokePath(context)
        
    }

}
