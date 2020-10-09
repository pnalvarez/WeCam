//
//  BaseCoordinatorProtocol.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 01/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol BaseRouterProtocol {
    var viewController: UIViewController? { get set }
    func routeTo(nextVC: UIViewController)
}
