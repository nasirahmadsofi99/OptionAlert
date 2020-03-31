//
//  OptionAlert.swift
//  OptionAlert
//
//  Created by Deftsoft on 03/03/20.
//  Copyright © 2020 Deftsoft. All rights reserved.
//

import UIKit

class OptionAlt: UIView {
    
     @IBOutlet var view: UIView!
     @IBOutlet var backView: UIImageView!
     @IBOutlet weak var firstButton: UIButton!
     @IBOutlet weak var firstLabel: UILabel!
     @IBOutlet weak var secondButton: UIButton!
     @IBOutlet weak var secondLabel: UILabel!
    
    
    //MARK: Setup
    convenience init(labelArray: [String] , imagesArray: [UIImage]) {
        
        self.init(frame: UIScreen.main.bounds)
        self.initialize(labelArray: labelArray,imagesArray: imagesArray)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: Private Methods
    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView { //Load View from Nib
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func initialize(labelArray: [String] , imagesArray: [UIImage]) {
        
        self.firstLabel.text! = labelArray[0]
        self.secondLabel.text! = labelArray[1]
        self.firstButton.setImage(imagesArray[0], for: .normal)
        self.secondButton.setImage(imagesArray[1], for: .normal)
        let tap = UITapGestureRecognizer(target: self, action: #selector(backClicked))
        tap.numberOfTouchesRequired = 1
        backView.addGestureRecognizer(tap)
        
       }
    
    
    
    @objc func backClicked() {
            self.remove()
        }

    //MARK: Show Alert
    func show() {
        self.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func remove() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.alpha = 0
        }, completion: {(success) in
            self.removeFromSuperview()
        })
    }
    
}


//For Handle Action
class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}


//Add Target With Closure
extension UIControl {
    func addTarget (action: @escaping ()->()) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: UIControl.Event.touchUpInside)
        objc_setAssociatedObject(self, String(ObjectIdentifier(self).hashValue) + String(UIControl.Event.touchUpInside.rawValue), sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
