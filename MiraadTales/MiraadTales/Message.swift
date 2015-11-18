//
//  Mensage.swift
//  MiraadTales
//
//  Created by Rodolfo José on 09/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

public class Message {
    
    public let id: Int
    public let text: String
    public let owner: AnyObject?
    public var shown: Bool
    public let item: AnyObject?
    
    public init(id: Int, text: String, owner: AnyObject? ,shown: Bool, item: AnyObject?) {
        self.id = id
        self.text = text
        self.owner = owner
        self.shown = shown
        self.item = item
    }
}
