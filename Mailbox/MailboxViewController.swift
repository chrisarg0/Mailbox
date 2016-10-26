//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Chris Argonish on 10/26/16.
//  Copyright © 2016 Chris. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    // view outlets
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reschedulView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var parentView: UIView!
    
    // gesture recognizer outlets
    @IBOutlet var screenEdgePanLeft: UIScreenEdgePanGestureRecognizer!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 375, height: 1508)
        
        // Whats wrong with this?
        //scrollView.contentSize = CGSize(feedImageView.frame.size + messageView.frame.size)
        
        scrollView.delegate = self
        
        // set gesture recognizer delegate
        panGesture.delegate = self
        
        ////////////////////////////////////////
        // INSTANTIATE PAN GESTURE RECOGNIZER //
        ////////////////////////////////////////
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panMessage(sender: panGesture)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        messageView.isUserInteractionEnabled = true
        messageView.addGestureRecognizer(panGestureRecognizer)
        
        ////////////////////////////////////////////////////
        // INSTANTIATE SCREEN EDGE PAN GESTURE RECOGNIZER //
        ///////////////////////////////////////////////////
        
        let screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didScreenPanEdgeLeft(sender: screenEdgePanLeft)))
        
        // Configure the screen edges you want to detect.
        screenEdgePanGestureRecognizer.edges = UIRectEdge.left
        
        // Attach the screen edge pan gesture recognizer to some view.
        parentView.isUserInteractionEnabled = true
        parentView.addGestureRecognizer(screenEdgePanGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////////////////////////////////////////////////
    // Gesture Recognizer Protocol Implementation //
    ///////////////////////////////////////////////
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
        // allows multiple gesture recognizes to be used simultaneously
    }
    
    @IBAction func panMessage(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
    }

    @IBAction func didScreenPanEdgeLeft(_ sender: UIScreenEdgePanGestureRecognizer) {
    }
    
    

}
