//
//  ViewAlert.swift
//  TesteDropDownAlert
//
//  Created by Matheus Baptista Bondan on 26/11/18.
//  Copyright © 2018 Vortigo. All rights reserved.
//

import UIKit

class ViewAlert: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var alertHeight:CGFloat?
    var viewWidth:CGFloat?
    var textXOffset:CGFloat?
    var notchedPhoneYOffset:CGFloat?
    var notchedPhoneXOffset:CGFloat?
    var displayInterval:CGFloat?
    var viewWasDismissed = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    func customInit(){
        Bundle.main.loadNibNamed("ViewAlert", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.layer.cornerRadius = 10
        
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.5
        self.contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.contentView.layer.shadowRadius = 2
        
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    init(title:String, image:String, displayTime:CGFloat){
        super.init(frame: CGRect.zero)
        customInit()
        
        configureiVarsWithImage(alertImage: UIImage(named: image), displayTime: displayTime)
        
        frame = frameAfterReset()
        titleLabel.text = title
        
        addGestureRecognizer(pan())
        
        tag = 595847
        
        if self.superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            
            for window in frontToBackWindows{
                if window.windowLevel == .normal && !window.isHidden{
                    window.addSubview(self)
                }
            }
        }
    }
    
    func configureiVarsWithImage(alertImage:UIImage?, displayTime:CGFloat) {
        displayInterval = (displayTime == 0) ? 4 : displayTime;
        alertHeight = 80
        viewWidth = UIScreen.main.bounds.size.width - 26
        
        if alertImage != nil {
            textXOffset = 70
        } else {
            textXOffset = 15
        }
        viewWasDismissed = false //Flag set when dismiss is called
        notchedPhoneYOffset = 0
        
    }
    
    func frameAfterReset() -> CGRect {
        let windowApp = UIApplication.shared.delegate?.window
        
        if #available(iOS 11, *), (windowApp!?.responds(to: #selector(getter: safeAreaInsets)))!{
            let i = UIApplication.shared.delegate?.window!?.safeAreaInsets
            
            if (i!.top > 0 || i!.right > 0) {
                notchedPhoneYOffset = i!.top > 20 ? 24 : 0
                notchedPhoneXOffset = i!.left > 0 ? 24 : 0
                alertHeight = alertHeight! + notchedPhoneYOffset!
            }
        }
        
        return CGRect(x: 13, y: -(self.alertHeight!) + 45 , width: self.viewWidth!, height: self.alertHeight!)
    }
    
    func pan() -> UIPanGestureRecognizer {
        return UIPanGestureRecognizer.init(target: self, action: #selector(userGestureDetected(_:)))
    }
    
    @objc func userGestureDetected(_ gesture: UIGestureRecognizer) {
        if gesture.isKind(of: UIPanGestureRecognizer.self) && gesture.state != .began {
            return
        }
        
        DispatchQueue.main.async {[weak self] in
            self?.dismissView(gesture: gesture)
        }
    }
    
    func dismissView(gesture:Any?) {
        if viewWasDismissed{
            return
        } else {
            viewWasDismissed = true
        }
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.5, animations: {
                var shiftFrame = self.frame
                shiftFrame.origin.y = shiftFrame.origin.y - self.alertHeight!
                self.frame = shiftFrame
            }, completion: { (finished) in
                self.cleanUp()
            })
        }
        
        self.perform(#selector(statusBarToTop), with: nil, afterDelay: 0.3)
    }
    
    @objc func statusBarToTop() {
        UIApplication.shared.delegate?.window!?.windowLevel = .normal
    }
    
    @objc func statusBarToBottom() {
        UIApplication.shared.delegate?.window!?.windowLevel = .normal + 1
    }
    
    func cleanUp() {
        removeFromSuperview()
    }
    
    func timedDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(displayInterval ?? 0))) {[weak self] in
            self?.dismissView(gesture: nil)
        }
    }
    
    func display() {
        statusBarToBottom()
        
        UIView.animate(withDuration: 0.5) {
            var shiftFrame = self.frame
            shiftFrame.origin.y = shiftFrame.origin.y + self.alertHeight!
            self.frame = shiftFrame
        }
        timedDismiss()
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        userGestureDetected(UITapGestureRecognizer.init(target: self, action: #selector(userGestureDetected(_:))))
    }
}



