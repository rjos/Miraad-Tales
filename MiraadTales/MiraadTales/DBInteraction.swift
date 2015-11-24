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
            
        }else if person is SKSpriteNode {
            
            namePerson = (person as! SKSpriteNode).name!
            
            if namePerson == "SKKey" {
                currentDialog = setConversationKey(size)
            }else if namePerson == "SKDoor" {
                currentDialog = setConversationCloseDoor(size)
            }else if namePerson == "OpenDoor" {
                currentDialog = setConversationOpenDoor(size)
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
    
    public static func getInteraction(size: CGSize) -> Dialog? {
        var currentDialog: Dialog? = nil
        
        currentDialog = setConversationProlog(size)
        
        if !conversation.keys.contains("Prolog") {
            conversation["Prolog"] = currentDialog
            return currentDialog
        }
        
        return conversation["Prolog"]
    }
    
    private static func setConversationRohan(rohan: Player, player: Player, size: CGSize) -> Dialog {
        
        let messages = [
            Message(id: 1, text: "Quem diria... O que uma garotinha está fazendo nesse lugar?", owner: rohan, shown: false, item: nil),
            Message(id: 2, text: "Garotinha? Olha quem fala. O que um cantor de bêbados faz aqui? Teve uma noite agitada?", owner: player, shown: false, item: nil),
            Message(id: 3, text: "Que delicada. É, acho melhor não tirar os olhos de você. Nunca se saba quando um monstro pode atacar.", owner: rohan, shown: false, item: nil),
            Message(id: 4, text: "Não, obrigada. Não preciso ser salva por um homem. Implicando que um alaúde sirva numa batalha...", owner: player, shown: false, item: nil),
            Message(id: 5, text: "Subestima meu poder? Então façamos o seguinte:", owner: rohan, shown: false, item: nil),
            Message(id: 6, text: "Já que a senhorita é uma guerreira tão poderosa por quê me vê lutar e julga minhas habilidades?", owner: rohan, shown: false, item: nil),
            Message(id: 7, text: "Caso lhe agrade, seguimos explorando essa caverna juntos. Combinado?", owner: rohan, shown: false, item: nil),
            Message(id: 8, text: "Certo, tudo bem. Mas não fique no meu caminho. Como você se chama? Meu nome é Hydora.", owner: player, shown: false, item: nil),
            Message(id: 9, text: "Que nome adorável! Eu me chamo Rohan. É um prazer lhe conhecer.", owner: rohan, shown: false, item: nil),
            Message(id: 10, text: "Rohan entrou na party", owner: nil, shown: true, item: nil)]
        
        
        let dialog = Dialog(messages: messages, action: ActionDialog.ShowMessage, size: size)
        
        return dialog
        
    }
    
    private static func setConversationProlog(size: CGSize) -> Dialog {
        
        let messages = [
            Message(id: 1, text: "O chão abriu-se sobre seus pés.", owner: nil, shown: false, item: nil),
            Message(id: 2, text: "Estava presa numa queda sem fim. O céu distanciava-se a cada segundo e a escuridão engulia-a.", owner: nil, shown: false, item: nil),
            Message(id: 3, text: "O fim da queda aguardava-a como uma cova aberta.", owner: nil, shown: false, item: nil)
        ]
        
        let dialog = Dialog(messages: messages, action: ActionDialog.OpenPage, size: size)
        
        return dialog
    }
    
    private static func setConversationKey(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "Você pegou a chave", owner: nil, shown: false, item: nil)]

        let dialog = Dialog(messages: messages, action: nil, size: size)
        
        return dialog
    }
    
    private static func setConversationCloseDoor(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "A porta está fechada. Pegue a chave para abri-la", owner: nil, shown: false, item: nil)]
        
        let dialog = Dialog(messages: messages, action: nil, size: size)
        
        return dialog
    }
    
    private static func setConversationOpenDoor(size: CGSize) -> Dialog {
        let messages = [
            Message(id: 1, text: "Você abriu a porta.", owner: nil, shown: false, item: nil)]
        
        let dialog = Dialog(messages: messages, action: nil, size: size)
        
        return dialog
    }
}