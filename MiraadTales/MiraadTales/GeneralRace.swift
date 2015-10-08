//
//  GeneralRace.swift
//  MiraadTales
//
//  Created by Rodolfo José on 07/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class GeneralRace: NSObject, StatusList {

    public let name: String
    public let status: PlayerStatus
    public var equipments: [Equip]
    public var skills: [BaseSkill]
    
    public init(name: String, status: PlayerStatus, equipments: [Equip], skills: [BaseSkill]) {
        self.name = name
        self.status = status
        self.equipments = equipments
        self.skills = skills
    }
    
    public func incrementHP() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
    
    public func incrementMP() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
    
    public func incrementPAtk() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
    
    public func incrementMAtk() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
    
    public func incrementPDef() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
    
    public func incrementMDef() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
    
    public func incremmentSpeed() {
        preconditionFailure("Function have bee implement for Sub Classes")
    }
}
