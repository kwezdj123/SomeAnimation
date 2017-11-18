//
//  aViewController.swift
//  SPS停车
//
//  Created by Mr.Zhu on 2017/11/17.
//  Copyright © 2017年 Zx. All rights reserved.
//

import UIKit

class aViewController: UIViewController,CALayerDelegate,CAAnimationDelegate {

    var circleLayer: CAShapeLayer!
    var leftsmallLayer:CAShapeLayer!
    var leftbigLayer:CAShapeLayer!
    var rightsmallLayer:CAShapeLayer!
    var rightbigLayer:CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLoadingCircle(count: 8, duration: 1.0, view: self.view)
       // yuanhuan()
      //wifiAnim()
       
    }
    
    //MARK:- 圆环动画(多种颜色圆环)
    @objc func addAnimation(){
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = 0.5
        anim.fromValue = 0
        anim.toValue = 1
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.isRemovedOnCompletion = true
        circleLayer.mask?.add(anim, forKey: "circleAnimation")
        
    }
    
    func yuanhuan(){
        let btn1 = UIButton()
        btn1.frame = CGRect(x: ScreenWidth/2, y: ScreenHeight/2+100.adaptation, width: 100.adaptation, height: 50.adaptation)
        btn1.layer.position = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2+100.adaptation)
        btn1.setTitle("动画", for: .normal)
        btn1.backgroundColor = UIColor.black
        btn1.setTitleColor(UIColor.white, for: .normal)
        btn1.addTarget(self, action: #selector(addAnimation), for: .touchUpInside)
        view.addSubview(btn1)
        let rect = CGRect(x: ScreenWidth/2, y: ScreenHeight/2, width: 100, height: 100)
     
        circleLayer = CAShapeLayer()
     
        circleLayer.addSublayer(createPartLayer(strokeStart: 0, strokeEnd: 0.8, rect: rect, strokeColor: UIColor.blue))
       
        circleLayer.addSublayer(createPartLayer(strokeStart: 0.8, strokeEnd: 0.9, rect: rect, strokeColor: UIColor.gray))
        circleLayer.addSublayer(createPartLayer(strokeStart: 0.9, strokeEnd: 0.95, rect: rect, strokeColor: UIColor.red))
        circleLayer.addSublayer(createPartLayer(strokeStart: 0.95, strokeEnd: 1.0, rect: rect, strokeColor: UIColor.orange))
        self.view.layer.addSublayer(circleLayer)
        circleLayer.mask = self.createPartLayer(strokeStart: 0, strokeEnd: 1.0, rect: rect, strokeColor: UIColor.black)
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = 0.5
        anim.fromValue = 0
        anim.toValue = 1
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.isRemovedOnCompletion = true
        circleLayer.mask?.add(anim, forKey: "circleAnimation")
    }
    
    func createPartLayer(strokeStart:CGFloat,strokeEnd:CGFloat,rect:CGRect,strokeColor:UIColor)->CAShapeLayer{
        let  PartLayer = CAShapeLayer()
        let center = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2)
        let radius = 50.adaptation
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2*3, clockwise: true)
        PartLayer.path = path.cgPath
        PartLayer.strokeColor = strokeColor.cgColor
        PartLayer.fillColor = UIColor.clear.cgColor
        PartLayer.lineWidth = 10.0
        PartLayer.strokeEnd = strokeEnd
        PartLayer.strokeStart = strokeStart
        PartLayer.lineCap = "bevel"
        return PartLayer
        
    }
    //MARK:- WIFI 动画
    func wifiAnim(){
        let bottomLayer: CAReplicatorLayer = CAReplicatorLayer()
        bottomLayer.backgroundColor = UIColor.clear.cgColor
        bottomLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        bottomLayer.position = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2)
        self.view.layer.addSublayer(bottomLayer)
        let dotLayer = CALayer()
        dotLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        dotLayer.position = CGPoint(x: 50, y: 50)
        dotLayer.cornerRadius = 5
        dotLayer.backgroundColor = UIColor.green.cgColor
        bottomLayer.addSublayer(dotLayer)
        let gungunLayer = CALayer()
        gungunLayer.bounds = CGRect(x: 0, y: 0, width: 6, height: 40)
        gungunLayer.position = CGPoint(x: 50, y: 80)
        gungunLayer.backgroundColor = UIColor.green.cgColor
        bottomLayer.addSublayer(gungunLayer)
        //画信号
        leftsmallLayer = CAShapeLayer()
        var leftsmallPath = UIBezierPath()
        leftsmallPath = UIBezierPath.init(arcCenter: dotLayer.position, radius: 15, startAngle: CGFloat.pi/4*3, endAngle: CGFloat.pi/4*5, clockwise: true)
        leftsmallLayer.path = leftsmallPath.cgPath
        leftsmallLayer.strokeColor = UIColor.green.cgColor
        leftsmallLayer.fillColor = UIColor.clear.cgColor
        leftsmallLayer.lineWidth = 8.0
        bottomLayer.addSublayer(leftsmallLayer)
        
        leftbigLayer = CAShapeLayer()
        var leftbigPath = UIBezierPath()
        leftbigPath = UIBezierPath.init(arcCenter: dotLayer.position, radius: 30, startAngle: CGFloat.pi/4*3, endAngle: CGFloat.pi/4*5, clockwise: true)
        leftbigLayer.path = leftbigPath.cgPath
        leftbigLayer.strokeColor = UIColor.green.cgColor
        leftbigLayer.fillColor = UIColor.clear.cgColor
        leftbigLayer.lineWidth = 8.0
        bottomLayer.addSublayer(leftbigLayer)
        
        rightsmallLayer = CAShapeLayer()
        var rightsmallPath = UIBezierPath()
        rightsmallPath = UIBezierPath.init(arcCenter: dotLayer.position, radius: 15, startAngle: -CGFloat.pi/4, endAngle: CGFloat.pi/4, clockwise: true)
        rightsmallLayer.path = rightsmallPath.cgPath
        rightsmallLayer.strokeColor = UIColor.green.cgColor
        rightsmallLayer.fillColor = UIColor.clear.cgColor
        rightsmallLayer.lineWidth = 8.0
        bottomLayer.addSublayer(rightsmallLayer)
        
        rightbigLayer = CAShapeLayer()
        var rightbigPath = UIBezierPath()
        rightbigPath = UIBezierPath.init(arcCenter: dotLayer.position, radius: 30, startAngle: -CGFloat.pi/4, endAngle: CGFloat.pi/4, clockwise: true)
        rightbigLayer.path = rightbigPath.cgPath
        rightbigLayer.strokeColor = UIColor.green.cgColor
        rightbigLayer.fillColor = UIColor.clear.cgColor
        rightbigLayer.lineWidth = 8.0
        bottomLayer.addSublayer(rightbigLayer)
        //动画
        //给底层layer添加闪烁效果(隐现都有动画)
       let opacityAnim1 = CABasicAnimation.opacityForever_Animation(time: 1.0, delay: 0, staticTime: 2.1, grouptime: nil)
       let opacityAnim2 = CABasicAnimation.opacityForever_Animation(time: 1.0, delay: 1.0, staticTime: 0.5, grouptime: 4.1)
        let opacityAnim3 = CABasicAnimation.opacityForever_Animation(time: 2.0, delay: 0, staticTime: 0.5, grouptime: 4.1)
        leftbigLayer.add(opacityAnim1, forKey: nil)
        rightbigLayer.add(opacityAnim1, forKey: nil)
        leftsmallLayer.add(opacityAnim2, forKey: nil)
        rightsmallLayer.add(opacityAnim2, forKey: nil)
        dotLayer.add(opacityAnim3, forKey: nil)
        gungunLayer.add(opacityAnim3, forKey: nil)
    }
    
    //MARK:- 圆点加载动画
    func addLoadingCircle(count:Int,duration:CGFloat,view:UIView){
        let replicatorLayer:CAReplicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        replicatorLayer.cornerRadius = 10.0
        replicatorLayer.position = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2)
        replicatorLayer.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.2).cgColor
        replicatorLayer.instanceCount = count//复制count个子layer
        
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat.pi*2/CGFloat(count), 0, 0, 1)
        view.layer.addSublayer(replicatorLayer)
        
        let dotLayer: CALayer = CALayer()
        dotLayer.transform = CATransform3DMakeScale(0, 0, 0)
        dotLayer.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        dotLayer.position = CGPoint(x: 16, y: replicatorLayer.frame.size.height/2)
        dotLayer.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6).cgColor
        dotLayer.cornerRadius = 7.5
        replicatorLayer.addSublayer(dotLayer)
        
        //动画
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.duration = CFTimeInterval(duration)
        anim.fromValue = 1
        anim.toValue = 0
        anim.repeatCount = MAXFLOAT
        dotLayer.add(anim, forKey: nil)
        replicatorLayer.instanceDelay = CFTimeInterval(duration/CGFloat(count))//每个子layer做动画的延迟的时间
    }
    //MARK:- CAAnimationDelegate
    func animationDidStart(_ anim: CAAnimation) {
        
    
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
        
    }
    

}
