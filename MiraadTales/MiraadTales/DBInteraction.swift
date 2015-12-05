//
//  DBInteraction.swift
//  MiraadTales
//
//  Created by Rodolfo José on 09/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//

import SpriteKit

public class DBInteraction {
    
    private static var conversation: [String: Dialog] = [:]
    
    public static func getInteraction(person: AnyObject?, player: Player, size: CGSize) -> Dialog? {
        
        var currentDialog: Dialog? = nil
        var namePerson: String = ""
        
        if person is Player {
            
            namePerson = (person as! Player).race.name
            
            if (person as! Player).race.name == "Rohan" {
                currentDialog = setConversationRohan((person as! Player), player: player, size: size)
            }
            
        }else if person is Enemy {
            namePerson = (person as! SKSpriteNode).name!
            
            if namePerson == "Bellatrix" {
                currentDialog = setConversationBellatrix((person as! Enemy), hydora: player, size: size)
            }
        }else if person is SKSpriteNode {
            
            namePerson = (person as! SKSpriteNode).name!
            
            if namePerson == "SKKey" {
                currentDialog = setConversationKey(size)
            }else if namePerson == "SKDoor" {
                currentDialog = setConversationCloseDoor(size)
            }else if namePerson == "OpenDoor" {
                currentDialog = setConversationOpenDoor(size)
            }else if namePerson == "Item" {
                currentDialog = setConversationGetItem((person as! Item),size: size)
            }
        }
        
        if currentDialog == nil || namePerson == "" {
            return nil
        }
        
        if !conversation.keys.contains(namePerson){
            conversation[namePerson] = currentDialog
            return currentDialog
        }
        
        return conversation[namePerson]
    }
    
    
    public static func getInteraction(person: AnyObject?, player: Player, player2: Player, size: CGSize) -> Dialog? {
        var currentDialog: Dialog? = nil
        var namePerson: String = ""

        if person is Enemy {
            
            namePerson = (person as! Enemy).race.name
            
            if namePerson == "Bellatrix" {
                currentDialog = setConversationBellatrix((person as! Enemy), hydora: player, rohan: player2, size: size)
                //currentDialog = setConversationBellatrix()
            }
            
        }
        
        if currentDialog == nil || namePerson == "" {
            return nil
        }
        
        if !conversation.keys.contains(namePerson){
            conversation[namePerson] = currentDialog
            return currentDialog
        }
        
        return conversation[namePerson]
    }
    
    public static func getInteraction(size: CGSize, isProlog: Bool) -> Dialog? {
        var currentDialog: Dialog? = nil
        
        if isProlog {
            currentDialog = setConversationProlog(size)
        }else {
            currentDialog = setConversationGameover(size)
        }
        
        if !conversation.keys.contains("Prolog") && isProlog {
            conversation["Prolog"] = currentDialog
            return currentDialog
        }else if !conversation.keys.contains("Gameover") {
            conversation["Gameover"] = currentDialog
            return currentDialog
        }
        
        if isProlog {
            return conversation["Prolog"]
        }else {
            return conversation["Gameover"]
        }
    }
    
    private static func setConversationRohan(rohan: Player, player: Player, size: CGSize) -> Dialog {
        
        let messages = [
            Message(id: 1, text: "What are you doing here? This is no place for little girls.", owner: rohan, shown: false, item: nil),
            Message(id: 2, text: "I've got a name. I'm Hydora. And I know how to defend myself.", owner: player, shown: false, item: nil),
            Message(id: 3, text: "Hydora, the pretty and strong warrior? Yes, it would give a good song.", owner: rohan, shown: false, item: nil),
            Message(id: 4, text: "I'm Rohan, the greatest bard of Miraad. May I make you company in your journey?", owner: rohan, shown: false, item: nil),
            Message(id: 5, text: "Do as you please, but don't get on my way.", owner: player, shown: false, item: nil),
            Message(id: 6, text: "ROHAN'S ENTERED THE PARTY", owner: nil, shown: true, item: nil)]
        
        let dialog = Dialog(messages: messages, action: ActionDialog.ShowMessage, size: size)
        
        return dialog
        
    }
    
    private static func setConversationBellatrix(bellatrix: Enemy, hydora:Player, rohan:Player, size:CGSize) -> Dialog{
        let messages = [
            Message(id: 1, text: "Hydora, be careful! This is Belatriz, the witch who's behind the attacks in Miraad.", owner: rohan, shown: false, item: nil),
            Message(id: 2, text: "Who are you to break into my house and even attack me?! This isn't going to be that way.", owner: bellatrix, shown: false, item: nil),
            Message(id: 3, text: "Rohan, be careful!", owner: hydora, shown: false, item: nil)]
        let dialog = Dialog(messages: messages, action: ActionDialog.OpenPage, size: size)
        return dialog
    }
    
    private static func setConversationBellatrix(bellatrix: Enemy, hydora: Player, size: CGSize) -> Dialog {
        
        let messages = [
            Message(id: 1, text: "Where's Mr. Bones? He should've been back from shopping.", owner: bellatrix, shown: false, item: nil),
            Message(id: 2, text: "Mr. Bones! I was so worried.", owner: bellatrix, shown: false, item: nil),
            Message(id: 3, text: "Your monsters are already finished, evil witch. You will no longer torment the good people of Miraad.", owner: hydora, shown: false, item: nil),
            Message(id: 4, text: "HOW DARE YOU?! Poor Mr. Bones! He is not to blame for causing fear in that coward people.", owner: bellatrix, shown: false, item: nil),
            Message(id: 5, text: "You are the evil one, breaking into my house and hurting my friends. You monster!", owner: bellatrix, shown: false, item: nil),
            Message(id: 6, text: "They told me you'd try to fool me. But I won't be manipulated. Get ready for your end!", owner: hydora, shown: false, item: nil)
        ]
        
        let dialog = Dialog(messages: messages, action: ActionDialog.OpenPage, size: size)
        
        return dialog
    }
    
    private static func setConversationProlog(size: CGSize) -> Dialog {
        
        let messages = [
            Message(id: 1, text: "Hydora was stuck in a endless fall.", owner: nil, shown: false, item: nil),
            Message(id: 2, text: "The sky was getting farther away at each second and the darkness was swallowing her.", owner: nil, shown: false, item: nil)
        ]
        
        let dialog = Dialog(messages: messages, action: ActionDialog.OpenPage, size: size)
        
        return dialog
    }
    
    private static func setConversationKey(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "Hydora got the key.", owner: nil, shown: false, item: nil)]

        let dialog = Dialog(messages: messages, action: nil, size: size)
        
        return dialog
    }
    
    private static func setConversationCloseDoor(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "The door is locked. Take the key to open it.", owner: nil, shown: false, item: nil)]
        
        let dialog = Dialog(messages: messages, action: nil, size: size)
        
        return dialog
    }
    
    private static func setConversationOpenDoor(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "Hydora opened the door.", owner: nil, shown: false, item: nil)]
        
        let dialog = Dialog(messages: messages, action: nil, size: size)
        
        return dialog
    }
    
    private static func setConversationGameover(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "Hydora! Hydoraaa! Wake up! We'll be late!", owner: nil, shown: false, item: nil)
        ]
        
        let dialog = Dialog(messages: messages, action: ActionDialog.OpenPage, size: size)
        
        return dialog
    }
    
    private static func setConversationGetItem(item: Item,size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "Hydora got the item.", owner: nil, shown: false, item: nil),
            Message(id: 2, text: "ITEM ADDED TO INVENTORY", owner: nil, shown: true, item: nil)
        ]

        let dialog = Dialog(messages: messages, action: ActionDialog.ShowMessage, size: size)
        
        return dialog
    }
}