//
//  ComposeEmailViewController.swift
//  Mailbox
//
//  Created by Chris Argonish on 10/29/16.
//  Copyright © 2016 Chris. All rights reserved.
//

import UIKit

class ComposeEmailViewController: UIViewController {

    @IBOutlet weak var emailConfirmation: UIImageView!
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var emailConfirmationText: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlay.alpha = 0
        emailConfirmation.alpha = 0
        emailConfirmationText.alpha = 0
        activityIndicator.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func didPressCancel(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)

        
    }
    
    @IBAction func didPressSend(_ sender: AnyObject) {
        overlay.alpha = 1
        emailConfirmation.alpha = 1
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        delay(1, closure: {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration:0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.emailConfirmation.transform = self.emailConfirmation.transform.scaledBy(x: 2.0, y: 2.0)
                            self.emailConfirmationText.alpha = 1
                            
                            self.emailConfirmationText.transform = self.emailConfirmationText.transform.scaledBy(x: 0.8, y: 0.8)
                            
                }, completion: nil)
            self.emailConfirmation.isHidden = false
            
            
            self.activityIndicator.isHidden = true
        })
        
        delay(2, closure: {
            self.performSegue(withIdentifier: "sentEmail", sender: nil)
        })
    }
    

}
