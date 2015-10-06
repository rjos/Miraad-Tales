//
//  Status.swift
//  MiraadTales
//
//  Created by Rodolfo José on 05/10/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import UIKit

public class Status: NSObject {
    
    // MARK: -Attributes
    public var HP: Int = 0
    public var MP: Int = 0
    public var Speed: Int = 0
    public var pAtk: Int = 0
    public var mAtk: Int = 0
    public var pDef: Int = 0
    public var mDef: Int = 0
    
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
