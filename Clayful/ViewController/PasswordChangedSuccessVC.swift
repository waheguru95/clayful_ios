//
//  PasswordChangedSuccessVC.swift
//  Clayful
//
//  Created by MTARTISTS on 13/07/22.
//

import UIKit

class PasswordChangedSuccessVC: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.setTitleFont("Login", fontName: AppFontName.mulishExtraBold, size: isIpadView ? 27 : 19)
    }

    @IBAction func actionBtnLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
