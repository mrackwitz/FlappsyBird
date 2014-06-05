//
//  SKPhysicsContactDelegateTrampoline.swift
//  FlappsyBird
//
//  Created by Marius Rackwitz on 05.06.14.
//  Copyright (c) 2014 Marius Rackwitz. All rights reserved.
//

import SpriteKit


typealias SKPhysicsContactFunction = ((SKPhysicsContact) -> ())?


class SKPhysicsContactDelegateTrampoline : NSObject, SKPhysicsContactDelegate {
    
    var _didBeginContact: SKPhysicsContactFunction?
    var _didEndContact: SKPhysicsContactFunction?
    
    init(didBeginContact: SKPhysicsContactFunction?, didEndContact: SKPhysicsContactFunction?) {
        self._didBeginContact = didBeginContact
        self._didEndContact = didEndContact
    }
    
    convenience init(didBeginContact: SKPhysicsContactFunction?) {
        self.init(didBeginContact: didBeginContact, didEndContact: nil)
    }
    
    convenience init(didEndContact: SKPhysicsContactFunction?) {
        self.init(didBeginContact: nil, didEndContact: didEndContact)
    }
    
    convenience init() {
        self.init(didBeginContact: nil, didEndContact: nil)
    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
        _didBeginContact??(contact)
    }
    
    func didEndContact(contact: SKPhysicsContact!) {
        _didEndContact??(contact)
    }
}


var contactDelegateTrampolineSelector : Selector = "contactDelegateTrampoline"
let contactDelegateTrampolineKey : CConstVoidPointer = &contactDelegateTrampolineSelector

extension SKScene {

    var _contactDelegateTrampoline : SKPhysicsContactDelegateTrampoline? {
        get {
            return objc_getAssociatedObject(self, contactDelegateTrampolineKey) as? SKPhysicsContactDelegateTrampoline
        }
        set {
            objc_setAssociatedObject(self, contactDelegateTrampolineKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }

    var contactDelegateTrampoline : SKPhysicsContactDelegateTrampoline {
        get {
            if _contactDelegateTrampoline == nil {
                // Lazy initialization
                self.contactDelegateTrampoline = SKPhysicsContactDelegateTrampoline()
            }
            return _contactDelegateTrampoline!
        }
        set {
            _contactDelegateTrampoline = newValue
            
            // Automatically set on PhysicsWorld
            self.physicsWorld.contactDelegate = newValue
        }
    }
    
    func setDidBeginContact(function: SKPhysicsContactFunction) {
        self.contactDelegateTrampoline._didBeginContact = function
    }

    func setDidEndContact(function: SKPhysicsContactFunction) {
        self.contactDelegateTrampoline._didEndContact = function
    }
    
}
