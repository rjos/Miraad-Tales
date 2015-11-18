//
//  Status.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Status {
    
    // MARK: -Attributes
    public var HP: Int
    public var MP: Int
    public var Speed: Int
    public var pAtk: Int
    public var mAtk: Int
    public var pDef: Int
    public var mDef: Int
    
    public init(HP:Int, MP:Int, Speed:Int, pAtk: Int, mAtk:Int, pDef: Int, mDef:Int) {
        self.HP = HP
        self.MP = MP
        self.Speed = Speed
        self.pAtk = pAtk
        self.mAtk = mAtk
        self.pDef = pDef
        self.mDef = mDef
    }
    
}
