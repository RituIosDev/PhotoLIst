//
//  CommonFunctions.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//

import Foundation
import UIKit

class CommonFunctions {
    //MARK: - Local Variables
    var viewBgTransluncent: UIView = UIView()
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    //MARK: - Shared Method
    class var sharedCommonFunctions : CommonFunctions {
        struct Static {
            static let instance : CommonFunctions = CommonFunctions()
        }
        return Static.instance
    }
    
    // MARK: - Loading indicator Methods
    func show_LoadingIndicator(strLoadingText: String) {
        if let viewAction = UIApplication.shared.keyWindowPresentedController?.view{
            viewAction.isUserInteractionEnabled = false
            
            let viewBgIndicator: UIView = UIView()
            let lblTitleIndicator: UILabel = UILabel()

            viewBgTransluncent.frame = viewAction.frame
            viewAction.addSubview(viewBgTransluncent)

            let widthOfIndicatorVw = CGFloat(180.0)
            let heightOfIndicatorVw = CGFloat(70.0)
            let xPointIndicatorVw = viewAction.frame.size.width/2
            let yPointIndicatorVw = viewAction.frame.size.height/2
            
            viewBgIndicator.frame = CGRect(x: CGFloat(xPointIndicatorVw - (widthOfIndicatorVw/2)), y: CGFloat(yPointIndicatorVw - (heightOfIndicatorVw/2)), width: widthOfIndicatorVw, height: heightOfIndicatorVw);
            viewBgIndicator.backgroundColor = UIColor.black
            viewBgIndicator.alpha = 0.7
            viewBgIndicator.layer.cornerRadius = 5
            viewBgIndicator.layer.masksToBounds = true
            viewBgIndicator.clipsToBounds = true
            viewBgTransluncent.addSubview(viewBgIndicator)
            
            actInd.style = .medium
            actInd.color = .white
            actInd.center = viewBgTransluncent.center
            actInd.hidesWhenStopped = true
            viewBgTransluncent.addSubview(actInd)
            actInd.startAnimating()
            
            lblTitleIndicator.frame = CGRect(x: 10, y: heightOfIndicatorVw-25, width: widthOfIndicatorVw-20, height: 20);
            lblTitleIndicator.text = strLoadingText
            lblTitleIndicator.textAlignment = .center
            lblTitleIndicator.textColor = UIColor.white
            viewBgIndicator.addSubview(lblTitleIndicator)
        }
    }
    
    func hide_LoadingIndicatorOnView() {
        if let viewAction = UIApplication.shared.keyWindowPresentedController?.view{
            viewAction.isUserInteractionEnabled = true
            actInd.stopAnimating()
            
            for item in viewBgTransluncent.subviews{
                item.removeFromSuperview()
            }
            viewBgTransluncent.removeFromSuperview()
        }
    }

    //MARK: - Alert On Key Window
    func alert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        UIApplication.shared.keyWindowPresentedController?.present(alert, animated: true, completion: nil)

    }
}

extension UIApplication {
    var keyWindowPresentedController: UIViewController? {
        let controller = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }

        var viewController = controller?.rootViewController
        
        // If root `UIViewController` is a `UITabBarController`
        if let presentedController = viewController as? UITabBarController {
            // Move to selected `UIViewController`
            viewController = presentedController.selectedViewController
        }
        
        // Go deeper to find the last presented `UIViewController`
        while let presentedController = viewController?.presentedViewController {
            // If root `UIViewController` is a `UITabBarController`
            if let presentedController = presentedController as? UITabBarController {
                // Move to selected `UIViewController`
                viewController = presentedController.selectedViewController
            } else {
                // Otherwise, go deeper
                viewController = presentedController
            }
        }
        
        return viewController
    }
    
}
