//
//  CustomFunctions.swift
//  Grandmasters
//
//  Created by APPLE MAC MINI on 13/03/18.
//  Copyright © 2018 APPLE MAC MINI. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UIView {
    
    @IBInspectable var ViewborderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var ViewcornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var ViewborderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    func setTopRoundCorners(radius : Float)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: CGFloat(radius), height: CGFloat(radius)))
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}


extension UIViewController
{
    func showAlert(title: String , message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func rotate3(imageView: UIImageView, aCircleTime: Double) { //CAKeyframeAnimation
    
    let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    animation.duration = aCircleTime
    animation.fillMode = kCAFillModeForwards
    animation.repeatCount = .infinity
    animation.values = [0, Double.pi/2, Double.pi, Double.pi*3/2, Double.pi*2]
    //Percentage of each key frame
    animation.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.1),
                          NSNumber(value: 0.3), NSNumber(value: 0.8), NSNumber(value: 1.0)]
    
    imageView.layer.add(animation, forKey: "rotate")
}


