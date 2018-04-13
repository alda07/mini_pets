//
//  ViewController.swift
//  Bookiie
//
//  Created by HanhVo on 5/13/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit
import GoogleMaps


class MainController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    
    private var selectedIndex = 0
    private var transitionPoint: CGPoint!
    private var navigator: UINavigationController!
    
    
    lazy private var menuAnimator : MenuTransitionAnimator! = MenuTransitionAnimator(mode: .Presentation, shouldPassEventsOutsideMenu: false) { [unowned self] in
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier, segue.destinationViewController) {
        case (.Some(BookieSegue.Menu.rawValue), let menu as MenuViewController):
            menu.selectedItem = selectedIndex
            menu.delegate = self
            menu.transitioningDelegate = self
            menu.modalPresentationStyle = .Custom
        case (.Some(BookieSegue.MainNavigation.rawValue), let navigator as UINavigationController):
            self.navigator = navigator
            self.navigator.delegate = self
        case (.Some(BookieSegue.MapView.rawValue), let navigator as UINavigationController):
            self.navigator = navigator
            self.navigator.delegate = self

        default:
            super.prepareForSegue(segue, sender: sender)
        }
    }
}

extension MainController: MenuViewControllerDelegate {
    
    func menu(_: MenuViewController, didSelectItemAtIndex index: Int, atPoint point: CGPoint) {
       
        transitionPoint = point
        selectedIndex = index
        
        let storyBoardName: NSString = Common.storyBoardName(selectedIndex)
        let content = storyboard!.instantiateViewControllerWithIdentifier(storyBoardName as String) 
       
        self.navigator.setViewControllers([content], animated: true)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func menuDidCancel(_: MenuViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

extension MainController: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController, animationControllerForOperation _: UINavigationControllerOperation,
                              fromViewController _: UIViewController, toViewController _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let transitionPoint = transitionPoint {
            return CircularRevealTransitionAnimator(center: transitionPoint)
        }
        return nil
    }
}

extension MainController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController _: UIViewController,
                                                   sourceController _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return menuAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuTransitionAnimator(mode: .Dismissal)
    }
    
}

