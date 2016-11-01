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
    @IBOutlet weak var menuView: UIImageView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var archiveFeedView: UIImageView!
    @IBOutlet weak var laterFeedView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reschedulView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var didTouchListViewItem: UIButton!
    @IBOutlet weak var didTouchRescheduleItem: UIButton!
    
    // message views
    @IBOutlet weak var leftPanView: UIView!
    @IBOutlet weak var rightPanView: UIView!
    
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
    var messageOriginalX: CGFloat!
    var feedOriginalX: CGFloat!
    var messageOriginalY: CGFloat!
    var feedOriginalY: CGFloat!
    var archiveFeedOriginalX: CGFloat!
    var laterFeedOriginalX: CGFloat!
    var mainViewOriginalX: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laterIcon.alpha = 0
        listIcon.alpha = 0
        archiveIcon.alpha = 0
        deleteIcon.alpha = 0
        reschedulView.alpha = 0
        listView.alpha = 0
        didTouchListViewItem.isHidden = true
        didTouchRescheduleItem.isHidden = true
        messageOriginalX = messageView.frame.origin.x
        messageOriginalY = messageView.frame.origin.y
        feedOriginalX = feedImageView.frame.origin.x
        feedOriginalY = feedImageView.frame.origin.y
        archiveFeedOriginalX = archiveFeedView.frame.origin.x
        laterFeedOriginalX = laterFeedView.frame.origin.x
        mainViewOriginalX = mainView.frame.origin.x
        
        messageOffset = 100
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: feedImageView.frame.origin.y + feedImageView.frame.size.height)
        scrollView.delegate = self
        
        let edgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didScreenEdgePan(sender:)))
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(edgePanGestureRecognizer)
        edgePanGestureRecognizer.delegate = self
        edgePanGestureRecognizer.edges = UIRectEdge.left
        
    }
    
    // Menu Functions
    
    func didScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        menuView.alpha = 1
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            
        } else if sender.state == .changed {
            self.mainView.frame.origin.x = self.mainViewOriginalX + translation.x
            
            
        } else if sender.state == .ended {
            if velocity.x > 0 {
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                    self.mainView.frame.origin.x = self.mainViewOriginalX + 315
                    }, completion: { (Bool) in
                })
            } else if velocity.x < 0{
                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                    self.mainView.frame.origin.x = self.mainViewOriginalX
                    
                    }, completion: { (Bool) in
                })
            }
        }
    }
    
    @IBAction func menuButton(_ sender: Any) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.mainView.frame.origin.x = self.mainViewOriginalX
        })
    }

    // Animator Functions
    
    func messageEscapeRight() {
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.messageView.center = self.leftPanView.center
            }, completion: { (finished: Bool) -> Void in
                self.messageCellDisappear()
                self.resetMessageCell()
        })
    }
    
    func messageBounceBackWhenGrey() {
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.messageView.center = self.originalCenter
            }, completion: nil)
    }
    
    // dismiss message view after swipe gesture
    func messageCellDisappear() {
        UIView.animate(withDuration: 0.2, animations: {
            self.messageView.transform = CGAffineTransform(translationX: 0, y: -100)
        })
    }
    
    // reset message view after dismiss
    func resetMessageCell() {
            self.messageView.frame.origin.x = self.messageOriginalX
            self.messageView.frame.origin.y = self.messageOriginalY
            self.messageView.center = self.originalCenter
            self.messageView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.messageView.alpha = 0
            self.messageView.alpha = 1
    }
    
    // dismiss list view
    @IBAction func didTouchListViewItem(_ sender: AnyObject) {
        didTouchListViewItem.isHidden = true
        listView.alpha = 0
        
        messageCellDisappear()
        resetMessageCell()
    }
    
    
    // dismiss reschedule view
    @IBAction func didTouchRescheduleItem(_ sender: AnyObject) {
        didTouchRescheduleItem.isHidden = true
        reschedulView.alpha = 0
        
        messageCellDisappear()
        resetMessageCell()

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
                
                rightPanView.alpha = convertValue(inputValue: abs(translation.x), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
                
                leftPanView.alpha = convertValue(inputValue: abs(translation.x), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
                
                if translation.x > 0 && translation.x < 60 {
                    // show grey, sliding right
                    rightPanView.backgroundColor = UIColor(red:0.92, green:0.93, blue:0.96, alpha:1.00)
                    archiveIcon.alpha = 0.5
                    deleteIcon.alpha = 0
                    
                } else if translation.x >= 60 && translation.x < 260 {
                    // show green
                    rightPanView.backgroundColor = UIColor(red:0.25, green:0.76, blue:0.43, alpha:1.00)
                    archiveIcon.alpha = 1
                    deleteIcon.alpha = 0                    
                } else if translation.x >= 260 {
                    // show red 
                    rightPanView.backgroundColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.00)
                    archiveIcon.alpha = 0
                    deleteIcon.alpha = 1
                } else if translation.x < 0 && translation.x > -60 {
                    // show grey, sliding left
                    leftPanView.backgroundColor = UIColor(red:0.92, green:0.93, blue:0.96, alpha:1.00)
                    laterIcon.alpha = 0.5
                    listIcon.alpha = 0
                    
                } else if translation.x <= -60 && translation.x > -260 {
                    // show yellow
                    leftPanView.backgroundColor = UIColor(red:0.97, green:0.91, blue:0.11, alpha:1.00)
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                } else if translation.x <= -260 {
                    // show brown
                    leftPanView.backgroundColor = UIColor(red:0.55, green:0.34, blue:0.16, alpha:1.00)
                    laterIcon.alpha = 0
                    listIcon.alpha = 1
                }
                
            } else if sender.state == .ended {
                if translation.x > 0 && translation.x < 60 {
                    // show grey, sliding right
                    messageBounceBackWhenGrey()
                } else if translation.x >= 60 && translation.x < 260 {
                    // show green
                    messageEscapeRight()
                } else if translation.x >= 260 {
                    // show red
                    messageEscapeRight()
                } else if translation.x < 0 && translation.x > -60 {
                    // show grey, sliding left
                    messageBounceBackWhenGrey()
                } else if translation.x <= -60 && translation.x > -260 {
                    // show reschedule options
                    UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options:[] ,
                                   animations: { () -> Void in
                                    self.messageView.center = self.rightPanView.center
                        }, completion: { (finished: Bool) -> Void in self.reschedulView.alpha = 1})
                    didTouchRescheduleItem.isHidden = false
                } else if translation.x <= -260 {
                    // show list options
                    UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options:[] ,
                                   animations: { () -> Void in
                                    self.messageView.center = self.rightPanView.center
                        }, completion: { (finished: Bool) -> Void in self.listView.alpha = 1})
                    didTouchListViewItem.isHidden = false
                }
            }
        }
    
        var interactor = Interactor()
    
// Segmented Control
    
    @IBAction func indexChanged(_ sender: AnyObject) {
            // STILL A LITTLE BUGGY
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                UIView.animate(withDuration: 0.3) {
                    self.archiveFeedView.frame.origin.x = self.archiveFeedOriginalX
                    self.laterFeedView.center.x = self.laterFeedView.center.x + 375
                }
            case 1:
                UIView.animate(withDuration: 0.3) {
                    self.laterFeedView.frame.origin.x = self.laterFeedOriginalX
                    self.archiveFeedView.frame.origin.x = self.archiveFeedOriginalX
                }
            case 2:
                UIView.animate(withDuration: 0.3) {
                    self.laterFeedView.center.x = self.laterFeedOriginalX
                    self.archiveFeedView.center.x = self.archiveFeedView.center.x - 375
                }
            default:
                break; 
            }
    }
    
// Screen Pan Edge Left
    
        @IBAction func didScreenPanEdgeLeft(_ sender: UIScreenEdgePanGestureRecognizer) {
            let translation = sender.translation(in: view)
            
            let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
            
            MenuHelper.mapGestureStateToInteractor(
                sender.state,
                progress: progress,
                interactor: interactor){
                    self.performSegue(withIdentifier: "openMenu", sender: nil)
            }
            
        }
    
    @IBAction func openMenu(_ sender: AnyObject) {
        performSegue(withIdentifier: "openMenu", sender: nil)
        
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
