//
//  TabBarViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 07.09.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    func setupTabBar() {
        let scheduleViewController = createNavController(viewController: MainViewController(), itemName: "Schedule".localized(), itemImage: "calendar")
        let deadlineViewController = createNavController(viewController: DeadlineViewController(), itemName: "Deadlines".localized(), itemImage: "calendar.badge.exclamationmark")
         viewControllers = [scheduleViewController, deadlineViewController]
    }

    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        return navigationController
    }
}
