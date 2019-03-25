//
//  TopLevel.swift
//  GitHubSearchTests
//
//  Created by Marko Polietaiev on 3/25/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import XCTest
import UIKit

class TopLevelUIUtilities<T: UIViewController> {
    
    private var rootWindow: UIWindow!

    func setupTopLevelUI(withViewController viewController: T) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow.isHidden = false
        rootWindow.rootViewController = viewController
        _ = viewController.view
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
    }
    
    func tearDownTopLevelUI() {
        guard let rootWindow = rootWindow as? UIWindow,
            let rootViewController = rootWindow.rootViewController as? T else {
                XCTFail("tearDownTopLevelUI() was called without setupTopLevelUI() being called first")
                return
        }
        rootViewController.viewWillDisappear(false)
        rootViewController.viewDidDisappear(false)
        rootWindow.rootViewController = nil
        rootWindow.isHidden = true
        self.rootWindow = nil
    }   

}
