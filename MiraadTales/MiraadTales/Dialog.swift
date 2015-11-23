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
    
    private var skBgDialog: SKSpriteNode? = nil
    
    private let skNodeMessage: SKSpriteNode!
    private var message: Message?
    
    private var skNodePerson: SKSpriteNode? = nil
    
    private var textureBgDialog: SKTexture? = nil
    
    private var showAction: Bool = false
    
    public var ended: Bool = false
    
    public var backgroundDialog: Bool = false {
        didSet {
            
            if backgroundDialog {
                self.textureBgDialog = SKTexture(imageNamed: "balao")
            }else {
                self.textureBgDialog = SKTexture(imageNamed: "")
            }
        }
    }
    
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
        
        //self.addChild(self.skNodeMessage)
        
        self.nextMessage()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Update Method
    public func update(currentTime: NSTimeInterval) {
        
        if begin {
            begin = false
            startTime = currentTime
        }
        
        if self.changeMessage && self.message == nil && !self.isEmpty {
            if self.skBgDialog != nil {
                self.skBgDialog!.removeAllChildren()
            }
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
                
                if self.isEmpty && self.showAction {
                    self.ended = true
                }
            }
        }
        
        if self.isEmpty && !self.showAction {
            self.showAction = true
            if self.action == ActionDialog.ShowMessage {
                self.message = self.messages[self.messages.count - 1]
                self.currentMessage.append(self.message!.text)
                self.skBgDialog!.removeAllChildren()
                self.skNodeMessage!.removeAllChildren()
                self.skBgDialog!.addChild(self.skNodeMessage!)
            }
        }
    }
    
    //MARK: Get next Message
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
                
                if self.message!.owner != nil {
                    self.skBgDialog = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: self.skNodeMessage.frame.width + 64, height: self.skNodeMessage.frame.height))
                    self.setPersonToMessage(self.message!.owner!)
                }else{
                    self.skBgDialog = SKSpriteNode(color: UIColor.clearColor(), size: self.skNodeMessage.frame.size)
                    self.skBgDialog!.addChild(self.skNodeMessage)
                }
                
                if self.textureBgDialog != nil {
                    self.skBgDialog!.texture = self.textureBgDialog
                }
                
                self.skBgDialog!.zPosition = 5
                self.addChild(self.skBgDialog!)
                
            }else {
                self.isEmpty = true
            }
        }else if self.message != nil {
            setMultiplesLines(self.message!.text)
        }
        
        return self.isEmpty
    }
    
    //MARK: Generate lines to message
    private func setMultiplesLines(message:String) {
        
        let separator = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        let words = message.componentsSeparatedByCharactersInSet(separator)
        
        let len = message.characters.count
        let width = 34;
        
        let toLine = (len / width) + 1
        var cnt = 0
        
        for var i = 0; i < toLine; ++i {
            var adding = false
            var lenPerLine = 0
            var strPerLine: String = ""
            
            while(lenPerLine < width) {
                if cnt > (words.count - 1) {
                    break;
                }
                
                adding = true
                strPerLine = "\(strPerLine) \(words[cnt])"
                lenPerLine = strPerLine.characters.count
                ++cnt
            }
            
            if adding {
                self.currentMessage.append(strPerLine)
            }
        }
        
        self.begin = true
    }
    
    //MARK: Create Label to message
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
    
    private func setPersonToMessage(person: AnyObject) {
        
        self.skBgDialog!.removeAllChildren()
        
        if person is Player {
            let name = (person as! Player).race.name
            self.skNodePerson = SKSpriteNode(imageNamed: "\(name)-2")
            
            self.skNodePerson!.position = CGPointMake((self.skNodePerson!.frame.width / 2)-(self.skBgDialog!.frame.width / 2) + 5, 0)
            
            self.skNodeMessage!.position = CGPointMake(self.skNodePerson!.position.x + (self.skNodePerson!.frame.width / 2) + (self.skNodeMessage!.frame.width / 2) - 5, 0)
            
        }else if person is Enemy {
            let name = (person as! Enemy).race.name
            self.skNodePerson = SKSpriteNode(imageNamed: "\(name)-2")
            
            self.skNodePerson!.position = CGPointMake((self.skBgDialog!.frame.width / 2) - (self.skNodePerson!.frame.width / 2) + 10, 0)
            
            self.skNodeMessage!.position = CGPointMake((self.skNodeMessage!.frame.width / 2) - (self.skBgDialog!.frame.width / 2), 0)
        }
        
        self.skNodePerson!.zPosition = 10
        self.skBgDialog!.addChild(self.skNodePerson!)
        self.skBgDialog!.addChild(self.skNodeMessage!)
        
    }
}