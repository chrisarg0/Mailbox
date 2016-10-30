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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var archiveFeedView: UIImageView!
    @IBOutlet weak var laterFeedView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reschedulView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var parentView: UIView!
    
    // message views
    @IBOutlet weak var leftPanView: UIView!
    @IBOutlet weak var rightPanView: UIView!
    @IBOutlet weak var leftButtonSet: UIImageView!
    @IBOutlet weak var rightButtonSet: UIImageView!
    
    // icons
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    // global variables
    var originalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    var messageOffset: CGFloat!
    var scrollViewOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laterIcon.alpha = 0
        listIcon.alpha = 0
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        
        
        messageOffset = 100
        // messageLeft = CGPoint(x: messageView.center.x + messageOffset, y: messageView.center.y)
        // messageRight = CGPoint(x: messageView.center.x - messageOffset, y: messageView.center.y)
        
        scrollView.contentSize = CGSize(width: 1125, height: 1508)
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
            // THIS NEEDS SOME WORK
            // Common properties to access from each gesture recognizer
            let translation = sender.translation(in: view)
            let velocity = sender.velocity(in: view)
            
            if sender.state == .began {
                
                originalCenter = messageView.center
                messageLeft = leftPanView.center
                messageRight = rightPanView.center
                
            } else if sender.state == .changed {
                
                messageView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y)
                
                if translation.x > 0 && translation.x < 60 {
                    // show grey, sliding right
                    rightButtonSet.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.00)
                    archiveIcon.alpha = 0.5
                    deleteIcon.alpha = 0
                    
                } else if translation.x >= 60 && translation.x < 260 {
                    // show green
                    rightButtonSet.backgroundColor = UIColor(red:0.25, green:0.76, blue:0.43, alpha:1.00)
                    archiveIcon.alpha = 1
                    deleteIcon.alpha = 0                    
                } else if translation.x >= 260 {
                    // show red 
                    rightButtonSet.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.00)
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 1
                } else if translation.x < 0 && translation.x > -60 {
                    // show grey, sliding left
                    leftButtonSet.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.00)
                    laterIcon.alpha = 0.5
                    listIcon.alpha = 0
                    
                } else if translation.x <= -60 && translation.x > -260 {
                    // show yellow
                    leftButtonSet.backgroundColor = UIColor(red:0.97, green:0.91, blue:0.11, alpha:1.00)
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                } else if translation.x <= -260 {
                    // show brown
                    leftButtonSet.backgroundColor = UIColor(red:0.55, green:0.34, blue:0.16, alpha:1.00)
                    laterIcon.alpha = 0
                    listIcon.alpha = 1
                }
                
            } else if sender.state == .ended {
                
            }
            
            // define what happens next
        }
    
        var interactor = Interactor()

    
        @IBAction func openMenu(_ sender: AnyObject) {
            performSegue(withIdentifier: "openMenu", sender: nil)
            
        }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        
        
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                UIView.animate(withDuration: 0.3) {
                    self.laterFeedView.center.x = self.laterFeedView.center.x + 375
                }
            case 1:
                // THIS NEEDS SOME WORK
                UIView.animate(withDuration: 0.3) {
                    if self.laterFeedView.center.x == 375 {
                        self.laterFeedView.center.x = 0
                    } else if self.archiveFeedView.center.x == 375 {
                        self.archiveFeedView.center.x = 750
                    }
                }

                scrollView.center.x = 0
            case 2:
                UIView.animate(withDuration: 0.3) {
                    self.archiveFeedView.center.x = self.archiveFeedView.center.x - 375                }
            default:
                break; 
            }
    }
    
// Screen Pan Edge Left
    
        @IBAction func didScreenPanEdgeLeft(_ sender: UIScreenEdgePanGestureRecognizer) {
            let translation = sender.translation(in: view)
            
            let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
            
            MenuHelper.mapGestureStateToInteractor(
                gestureState: sender.state,
                progress: progress,
                interactor: interactor){
                    self.performSegue(withIdentifier: "openMenu", sender: nil)
            }
            
        }

// For custom menu animation
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destination as? MailboxViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
        }
    }
    
}

extension MailboxViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
