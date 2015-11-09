//
//  Dialog.swift
//  MiraadTales
//
//  Created by Rodolfo José on 09/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

public class Dialog {
    
    public let owner: Enemy
    public let messages: [Message]
    
    public init(owner: Enemy, messages: [Message]) {
        self.owner = owner
        self.messages = messages
    }
}