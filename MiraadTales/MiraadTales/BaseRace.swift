//
//  GeneralRace.swift
//  MiraadTales
//
//  Created by Rodolfo José on 07/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class BaseRace: NSObject, StatusList {

    public let name: String
    public let status: PlayerStatus
    public var equipments: [Equip]
    public var skills: [Skill]
    
    public init(name: String, status: PlayerStatus, equipments: [Equip], skills: [Skill]) {
        self.name = name
        self.status = status
        self.equipments = equipments
        self.skills = skills
    }
    
    public func incrementHP() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementMP() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementPAtk() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementMAtk() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementPDef() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incrementMDef() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
    
    public func incremmentSpeed() {
        preconditionFailure("Function must be implemented by Sub Classes")
    }
}
