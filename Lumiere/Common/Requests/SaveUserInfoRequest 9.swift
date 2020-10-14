//
//  SaveUserInfoRequest.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 25/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

struct SaveUserInfoRequest {
    let image: Data?
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let professionalArea: String
    let interestCathegories: [String]
    let userId: String
}
