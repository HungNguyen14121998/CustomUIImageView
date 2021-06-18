//
//  SwiftyAvatar.swift
//  SwiftyAvatar
//
//  Created by Dimitrios Kalaitzidis on 04/08/16.
//  Copyright © 2016 Dimitrios Kalaitzidis. All rights reserved.
//

import UIKit

@IBDesignable public class SwiftyAvatar: UIImageView {
    
    init(size:CGFloat = 200, roundess:CGFloat = 2, borderWidth:CGFloat = 5, borderColor:UIColor = UIColor.blue, background:UIColor = UIColor.clear){
        self.roundness = roundess
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.background = background
        
        
        
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
    }
    
    init(name: String, image: UIImage?) {
        var initializationImage = UIImage()
        
        if image != nil {
            initializationImage = image!
        }
        else {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
            initializationImage = renderer.image { ctx in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                let font = UIFont(name: "HelveticaNeue-Medium", size: 100)!
                let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.black]
                let string = name
                let cgRect = CGRect(x: 0, y: 40, width: 200, height: 200)
                string.draw(with: cgRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            }
        }
        
        super.init(image: initializationImage)
    }
    
    //
    
    @IBInspectable var name: String = "" {
        didSet{
            setNeedsLayout()
        }
    }
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var roundness: CGFloat = 2 {
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 5 {
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.blue {
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var background: UIColor = UIColor.clear {
        didSet{
            setNeedsLayout()
        }
    }
    
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / roundness
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.backgroundColor = background.cgColor
        clipsToBounds = true
        
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: bounds.width / roundness)
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        layer.mask = mask
    }
}
