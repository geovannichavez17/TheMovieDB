//
//  BaseCoordinator.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 25/2/24.
//

import UIKit

protocol CoordinatorProtocol {
    func addChildCoordinator(_ coordinator: CoordinatorProtocol)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}

class BaseCoordinator: CoordinatorProtocol {
    
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    weak var navigationController: UINavigationController? // The reference is weak to prevent a retain cycle
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

