//
//  Extension.swift
//  SPS停车
//
//  Created by Mr.Zhu on 2017/11/16.
//  Copyright © 2017年 Zx. All rights reserved.
//

import Foundation
import UIKit
//MARK:- CABasicAnimation
extension CABasicAnimation{
    class func opacityForever_Animation(time:TimeInterval,delay:TimeInterval,staticTime:TimeInterval,grouptime:TimeInterval?)->CAAnimationGroup{
        let animGroup = CAAnimationGroup()
        
        let animation1 = CABasicAnimation(keyPath:"opacity")
        animation1.beginTime = 0+delay
        animation1.fromValue = 1
        animation1.toValue = 0
        
        animation1.duration = time
        //animation1.autoreverses = true
        animation1.fillMode = "forwards"
        animation1.isRemovedOnCompletion = false
        animation1.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        let animation2 = CABasicAnimation(keyPath:"opacity")
        animation2.beginTime = time+delay+staticTime
        animation2.fromValue = 0
        animation2.toValue = 1
        
        animation2.duration = time
        //animation2.autoreverses = true
        animation2.fillMode = "forwards"
        animation2.isRemovedOnCompletion = false
        animation2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        animGroup.animations = [animation1,animation2]
        animGroup.repeatCount = MAXFLOAT
        if grouptime == nil{
            animGroup.duration = time*2 + delay + staticTime
             return animGroup
        }
        animGroup.duration = grouptime!
        return animGroup
    }
}

//MARK:- 数值
extension CGFloat{
    var adaptation:CGFloat{
        let scale = ScreenWidth/375
        return self*scale
    }
}

extension Double{
    var adaptation:Double{
        let scale = Double(ScreenWidth/375)
        return self*scale
    }
}

extension Int{
    var adaptation:CGFloat{
        let scale = ScreenWidth/375
        return CGFloat(self)*scale
    }
}
//MARK:- UIImage
extension UIImage{
    /// 更改图片颜色
    public func imageWithTintColor(color : UIColor,alpha:CGFloat) -> UIImage{
        
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: alpha)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        //tintedImage?.stretchableImage(withLeftCapWidth: 2, topCapHeight:2)
        return tintedImage!
    }
    
}

extension UIImage{
   
    var MostColor: UIColor {
        // 获取图片信息
        let imgWidth:Int = Int(self.size.width)
        let imgHeight:Int = Int(self.size.height)
        
        // 位图的大小＝图片宽＊图片高＊图片中每点包含的信息量
        let bitmapByteCount = imgWidth*imgHeight*4
        
        // 使用系统的颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 根据位图大小，申请内存空间
        let bitmapData = malloc(bitmapByteCount)
        defer {free(bitmapData)}
        
        // 创建一个位图
        let context = CGContext(data: bitmapData,
                                width: imgWidth,
                                height: imgHeight,
                                bitsPerComponent:8,
                                bytesPerRow: imgWidth * 4,
                                space: colorSpace,
                                bitmapInfo:CGImageAlphaInfo.premultipliedLast.rawValue)
        
        // 图片的rect
        let rect = CGRect(x:0, y: 0, width:CGFloat(imgWidth), height: CGFloat(imgHeight))
        // 将图片画到位图中
        context?.draw(self.cgImage!, in: rect)
        
        // 获取位图数据
        let bitData = context?.data
        let data = unsafeBitCast(bitData, to:UnsafePointer<CUnsignedChar>.self)
        
        let cls = NSCountedSet.init(capacity: imgWidth * imgHeight)
        for x in 0..<imgWidth {
            for y in 0..<imgHeight {
                let offSet = (y * imgWidth + x)*4
                let r = (data + offSet).pointee
                let g = (data + offSet + 1).pointee
                let b = (data + offSet + 2).pointee
                let a = (data + offSet + 3).pointee
                if a > 0 {//去除透明
                    if !(r == 255 && g == 255 && b == 255) { //去除白色
                        cls.add([CGFloat(r),CGFloat(g), CGFloat(b),CGFloat(a)])
                    }
                }
            }
        }
        
        //找到出现次数最多的颜色
        let enumerator = cls.objectEnumerator()
        print("colors---\(cls)")
        var maxColor:Array<CGFloat>? = nil
        var maxCount = 0
        while let curColor = enumerator.nextObject() {
            let tmpCount = cls.count(for: curColor)
            if tmpCount >= maxCount{
                maxCount = tmpCount
                maxColor = curColor as? Array<CGFloat>
            }
        }
        return UIColor.init(red: (maxColor![0] / 255), green: (maxColor![1] / 255), blue: (maxColor![2] / 255), alpha: (maxColor![3] / 255))
    }
    
}


