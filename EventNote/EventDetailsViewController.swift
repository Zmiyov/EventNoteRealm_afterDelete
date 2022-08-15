//
//  EventDetailsViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 15.08.2022.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var event: Event?
    
//    init?(coder: NSCoder, event: Event) {
//        
//        self.event = event
//        super.init(coder: coder)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss",
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(dismissSelf))
        
        view.backgroundColor = .lightGray
  
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    

}
