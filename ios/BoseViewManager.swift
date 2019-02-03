//
//  BoseViewManager.swift
//  awp2
//
//  Created by PB on 2/2/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit;

@objc(BoseViewManager)
class BoseViewManager: RCTViewManager {
  
  override func view() -> UIView! {
    return BoseView()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
}

