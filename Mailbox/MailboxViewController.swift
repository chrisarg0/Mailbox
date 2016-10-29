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
    
    var originalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    var messageOffset: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageOffset = 100
        messageLeft = CGPoint(x: messageView.center.x + messageOffset, y: messageView.center.y)
        
        scrollView.contentSize = CGSize(width: 375, height: 1508)
        scrollView.delegate = self

        // Whats wrong with this?
        //scrollView.contentSize = CGSize(feedImageView.frame.size + messageView.frame.size)
    
        
        ////////////////////////////////////////
        // INSTANTIATE PAN GESTURE RECOGNIZER //
        ////////////////////////////////////////
        
        // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panMessage(sender:)))
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        //messageView.isUserInteractionEnabled = true
        //messageView.addGestureRecognizer(panGestureRecognizer)
        
        ////////////////////////////////////////////////////
        // INSTANTIATE SCREEN EDGE PAN GESTURE RECOGNIZER //
        ///////////////////////////////////////////////////
        
        //let screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didScreenPanEdgeLeft(sender:)))
        
        // Configure the screen edges you want to detect.
        //screenEdgePanGestureRecognizer.edges = UIRectEdge.left
        
        // Attach the screen edge pan gesture recognizer to some view.
        //parentView.isUserInteractionEnabled = true
        //parentView.addGestureRecognizer(screenEdgePanGestureRecognizer)
    
    ////////////////////////////////////////////////
    // Gesture Recognizer Protocol Implementation //
    ///////////////////////////////////////////////
    
    //func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      //  return true
        // allows multiple gesture recognizes to be used simultaneously
    }
    

@IBAction func panMessage(_ sender: UIPanGestureRecognizer) {
        
        // Common properties to access from each gesture recognizer
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
    
    if sender.state == .began {
        
        originalCenter = messageView.center
        
    } else if sender.state == .changed {
        
        messageView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
        
    } else if sender.state == .ended {
    
    }
    
        // define what happens next
    }

    @IBAction func didScreenPanEdgeLeft(_ sender: UIScreenEdgePanGestureRecognizer) {
        // Common properties to access from each gesture recognizer
        

        // define what happens next

    }
    
    

}
