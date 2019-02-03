//
//  BoseView.swift
//  awp2
//
//  Created by PB on 2/2/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import BoseWearable;

  class BoseView: UIView {
    weak var boseViewController: UIViewController?
    var session: WearableDeviceSession!
    var bose: Bose?
    
    @objc var count = 0 {
      didSet {
        button.setTitle(String(describing: count), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
     // self.session=?
      self.addSubview(button)
      increment()
    }
    
    
    private func showDeviceInfo(for session: WearableDeviceSession) {
     // guard let vc = storyboard?.instantiateViewController(withIdentifier: "DeviceTableViewController") as? DeviceTableViewController else {
      //  fatalError("Cannot instantiate view controller")
      //}
      self.session = session
     // vc.session = session
      //parentViewController!.show(parentViewController ?? <#default value#>, sender: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    lazy var button: UIButton = {
      let b = UIButton.init(type: UIButton.ButtonType.system)
      b.titleLabel?.font = UIFont.systemFont(ofSize: 50)
      b.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      b.addTarget(
        self,
        action: #selector(increment),
        for: .touchUpInside
      )
      return b
    }()
    
    @objc func increment() {
      count += 1

     
      BoseWearable.shared.startDeviceSearch(mode: .alwaysShowUI) { result in
        
        switch result {
        case .success(let session):
          // A device was selected. The session encapsulates communications with
          // the selected device.
          
          // Retain the session.
          self.session = session
          self.bose = Bose(device: session.device!)
          
          // Become the session's delegate to receive connectivity events.
          self.session.delegate = self.bose
          
          // Open the session.
          self.session.open()
          
       case .failure(let error):
          // An error occurred while performing the device search. Show the error
          // to the user.
        fatalError( error.localizedDescription)
        
        // parentViewController.show(error)
          
        case .cancelled:
          // The user cancelled the search.
          break
        
        }
      }    }
    
}
extension UIView {
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}

