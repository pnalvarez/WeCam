//
//  BaseCoordinatorProtocol.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

@objc enum RoutingMethod: Int {
    case modal
    case push
}

@objc protocol BaseRouterProtocol {
    @objc optional var routingMethod: RoutingMethod { get }
    var viewController: UIViewController? { get set }
    func routeTo(nextVC: UIViewController)
}

