//
//  LogoutPopupVC.swift
//  Clayful
//
//  Created by MTARTISTS on 14/07/22.
//

import UIKit

class LogoutPopupVC: UIViewController {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBOutlet weak var cnstTrailingVwMainDetail: NSLayoutConstraint!
    @IBOutlet weak var cnstLeadingVwMainDetail: NSLayoutConstraint!
    
    var callbackLogout:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogout.setTitleFont("Log out", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 29 : 19)
        btnCancel.setTitleFont("Cancel", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 29 : 19)
        
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 280
                cnstTrailingVwMainDetail.constant = 280
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            debugPrint("Landscape")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 280
                cnstTrailingVwMainDetail.constant = 280
            }
        } else {
            debugPrint("Portrait")
            if isIpadView {
                cnstLeadingVwMainDetail.constant = 120
                cnstTrailingVwMainDetail.constant = 120
            }
        }
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        self.dismiss(animated: true) {
            self.callbackLogout?()
        }
    }
    
    @IBAction func actionBtnCancel(_ sender: Any) {
        self.dismissViewController(true)
    }

}
