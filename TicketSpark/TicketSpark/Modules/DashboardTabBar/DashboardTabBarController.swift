//
//  DashboardTabBarController.swift
//  TicketSpark
//
//  Created by Apple on 28/02/24.
//

import UIKit

enum TabType {
    
    case dashboard
    case manageEvent
    case order
    case settings
    
    var item:Int {
        switch self {
        case .dashboard:
            return 0
        case .manageEvent:
            return 1
        case .order:
            return 2
        case .settings:
            return 3
        }
    }
}

class DashboardTabBarController: UITabBarController {

    var tabType:TabType = .dashboard
    
   // @IBOutlet weak var mainTabBar: MainTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = tabType.item
    }
}
