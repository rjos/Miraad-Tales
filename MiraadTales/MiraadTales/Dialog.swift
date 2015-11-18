//
//  Dialog.swift
//  MiraadTales
//
//  Created by Rodolfo José on 09/11/15.
//  Copyright © 2015 Rodolfo José. All rights reserved.
//
import SpriteKit

public class Dialog: SKNode {
    
    public let messages: [Message]
    public let action: ActionDialog
    public var isEmpty: Bool
    public var changeMessage: Bool
    public var velocity: NSTimeInterval = 0.1
    
    private let skNodeMessage: SKSpriteNode!
    private var message: Message?
    
    var begin: Bool = false
    var startTime:NSTimeInterval = 0.0
    var currentMessage: [String] = []
    var countCharacter = 0
    var countLine = 0
    
    public init(messages: [Message], action: ActionDialog, size: CGSize) {
        self.messages = messages
        self.action = action
        
        self.isEmpty = false
        self.changeMessage = false
        
        self.skNodeMessage = SKSpriteNode(color: UIColor.clearColor(), size: size)
        self.skNodeMessage.zPosition = 50
        self.skNodeMessage.position = CGPointMake(0, 0)
        
        super.init()
        
        self.addChild(self.skNodeMessage)
        
        self.nextMessage()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func nextMessage() -> Bool {
        
        if self.message == nil && self.changeMessage {
            var messages = self.messages
            messages = messages.sort({ (a, b) -> Bool in
                a.id < b.id
            })
            
            messages = messages.filter({ (a) -> Bool in
                !a.shown
            })
            
            if !messages.isEmpty {
                let message = messages.first!
                message.shown = true
                //Set nodes from dialog
                self.message = message
                
                setMultiplesLines(self.message!.text)
            }else {
                self.isEmpty = true
            }
        }else if self.message != nil {
            setMultiplesLines(self.message!.text)
        }
        
        return self.isEmpty
    }
    
    private func setMultiplesLines(message:String) {
        
        let separator = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        let words = message.componentsSeparatedByCharactersInSet(separator)
        
        let len = message.characters.count
        let width = 34;
        
        let toLine = (len / width) + 1
        var cnt = 0
        
        for var i = 0; i < toLine; ++i {
            var lenPerLine = 0
            var strPerLine: String = ""
            
            while(lenPerLine < width) {
                if cnt > (words.count - 1) {
                    break;
                }
                
                strPerLine = "\(strPerLine) \(words[cnt])"
                lenPerLine = strPerLine.characters.count
                ++cnt
            }
            
            self.currentMessage.append(strPerLine)
        }
        
        self.begin = true
    }
    
    private func createLabel(message: String, line: Int) {
        
        let lastedMessage = self.skNodeMessage.childNodeWithName("label-\(line)")
        
        if lastedMessage != nil {
            lastedMessage?.removeFromParent()
        }
        
        let size = self.skNodeMessage.calculateAccumulatedFrame().size
        
        let skMessage = SKLabelNode(text: message)
        skMessage.fontColor = UIColor.whiteColor()
        skMessage.horizontalAlignmentMode = .Left
        skMessage.fontName = "Prospero-Bold-NBP"
        skMessage.name = "label-\(line)"
        skMessage.position = CGPointMake(-(size.width / 2) + 30, -CGFloat((self.countLine * 30) - 30));
        self.skNodeMessage.addChild(skMessage)
    }
    
    public func update(currentTime: NSTimeInterval) {
        
        if begin {
            begin = false
            startTime = currentTime
        }
        
        if self.changeMessage && self.message == nil && !self.isEmpty {
            self.skNodeMessage!.removeAllChildren()
            self.nextMessage()
        }
        
        if (currentTime - startTime) >= velocity && self.currentMessage.count > 0 && self.message != nil {
            startTime = currentTime
            createLabel(currentMessage[countLine][0...countCharacter], line: countLine)
            ++countCharacter
            
            if countCharacter == currentMessage[countLine].characters.count {
                self.countCharacter = 0
                ++self.countLine
            }
            
            if self.countLine == currentMessage.count {
                self.message = nil
                self.countLine = 0
                self.currentMessage.removeAll()
                self.changeMessage = false
            }
        }
    }
}