//
//  LoaderVC.swift
//  Clayful
//
//  Created by netset on 16/07/22.
//

import UIKit

class LoaderVC: UIViewController {

    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVwLoader: UIImageView!
    @IBOutlet weak var vwYellow: UIView!
    @IBOutlet weak var cnstBottomVwYellow: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cnstBottomVwYellow.constant = 0
        imgVwLoader.image = UIImage.gifImageWithName(name: "safe-gif")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.cnstBottomVwYellow.constant = 160
                self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imgVwLoader.image = nil
    }

}
