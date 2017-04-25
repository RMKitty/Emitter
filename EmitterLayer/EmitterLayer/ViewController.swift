//
//  ViewController.swift
//  EmitterLayer
//
//  Created by Kitty on 2017/4/25.
//  Copyright © 2017年 RM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatCAEmitterLayer()
        likeShow()
    }
}
extension ViewController {
    // 下雪效果
    fileprivate func creatCAEmitterLayer() {
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        view.layer.insertSublayer(emitter, at: 0)
        emitter.emitterShape = kCAEmitterLayerRectangle //发射器形状
        emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2) //发射器位置
        emitter.emitterSize = rect.size //发射器大小
        //        emitter.renderMode = kCAEmitterLayerAdditive  // 重叠部分渲染模式
        let emitterCell = CAEmitterCell()
        emitterCell.name = "snow"
        emitterCell.birthRate = 100 // 每秒产生多少个粒子
        emitterCell.lifetime = 3 // 粒子生命周期
        emitterCell.lifetimeRange = 1 //  3-1 ~ 3+1 -> 2~4
        
        emitterCell.emissionLatitude = CGFloat(Double.pi / 2)    // 向右 x方向
        //        emitterCell.emissionLongitude = CGFloat(Double.pi / 2)  //  向下 y方向（顺时针）
        emitterCell.emissionRange = CGFloat(Double.pi / 2)     //   围绕发射方向的弧度数
        emitterCell.spinRange = CGFloat(Double.pi)            //    自动旋转弧度
        
        emitterCell.velocity = 20.0                          //     初始速度
        emitterCell.velocityRange = 10.0                    //      速度变化范围
        emitterCell.yAcceleration = 70.0                   //       粒子Y方向加速度分量
        
        emitterCell.contents = scaleImageToWidth(width: 30.0, image: UIImage(named: "timg.jpg")!).cgImage
        //        emitterCell.color    = UIColor(red: 1.0, green: 0.5, blue: 0.1, alpha: 1.0).cgColor
        
        emitterCell.scale = 0.6                          //          粒子缩放比例
        emitterCell.scaleRange = 0.6                    //
        emitterCell.scaleSpeed = -0.2                  //            逐渐变小
        
        emitterCell.alphaSpeed = -0.15                //             逐渐变透明
        emitterCell.alphaRange = 0.8                 //              一个粒子的颜色alpha能改变的范围
        emitter.emitterCells   = [emitterCell]
        
        /*
         emitter.shadowOpacity  = 1.0
         emitter.shadowRadius   = 0.0
         emitter.shadowOffset   = CGSize(width: 0.0, height: 1.0)
         //粒子边缘的颜色
         emitter.shadowColor = UIColor.blue.cgColor
         */
    }
    // 点赞喜欢效果
    fileprivate func likeShow() {
        
        let rect = CGRect(x: view.bounds.width - 100, y: view.bounds.height - 150, width: 30, height:30)
        let emmitter = CAEmitterLayer()
        emmitter.frame = rect
        view.layer.insertSublayer(emmitter, at: 0)
        emmitter.emitterPosition = CGPoint(x: rect.width / 2, y: rect.height / 2)
        emmitter.emitterSize = rect.size
        emmitter.renderMode = kCAEmitterLayerUnordered
        
        var emitterCells = [CAEmitterCell]()
        for _ in 0...8 {
            let cell = CAEmitterCell()
            cell.name = "like"
            cell.birthRate = 1
            cell.lifetime = Float(arc4random_uniform(3) + 1)
            cell.lifetimeRange = 1.0
            
            cell.contents       = scaleImageToWidth(width: 40, image: UIImage(named: "x.jpeg")!).cgImage
            cell.velocity       = CGFloat(arc4random_uniform(80) + 40)
            cell.velocityRange  = 40
            cell.emissionLongitude = CGFloat(Double.pi + Double.pi / 2)
            cell.emissionRange  = CGFloat(Double.pi / 8)
            cell.scale          = 0.4
            emitterCells.append(cell)
            
        }
        emmitter.emitterCells = emitterCells
        
    }
}
extension ViewController {
    
    /// ScaleImageToSpecticalWidth
    /// params: width  and original image
    /// return a scale UIImage
    fileprivate func scaleImageToWidth(width: CGFloat, image: UIImage) -> UIImage {
        if image.size.width < width {
            return image
        }
        let height = width * image.size.height / image.size.width
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result!
    }
}
