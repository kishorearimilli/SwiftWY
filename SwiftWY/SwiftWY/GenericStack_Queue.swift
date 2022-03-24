//
//  GenericStack_Queue.swift
//  SwiftWY
//
//  Created by Venkata Rama Kishore on 31/01/20.
//  Copyright © 2020 Venkata Rama Kishore. All rights reserved.
//

import Foundation

public class LNode<T> where T: Equatable {
    var val:T
    var next:LNode?
    init(value:T) {
        self.val = value
    }
}

public class Queue<T> where T: Equatable {
    private var head:LNode<T>?
    private var lastRef:LNode<T>?
    private var count:Int = 0
    public var length: Int {
        get {
            return count
        }
    }
    
    public var topElement: T? {
        get {
            guard let topElem = self.lastRef else {
                return nil
            }
            return topElem.val
        }
    }
    
    public func Enqueue(val:T) -> Void {
        
        let node = LNode(value: val)
        
        if let _ = self.head, let rear = self.lastRef {
            rear.next = node
            self.lastRef = node
        }
        else {
            head = node
            lastRef = node
        }
        count += 1
    }
    
    public func Dequeue() -> T? {
        guard let temp = self.head else {
            return nil
        }
        let val = temp.val
        self.head = temp.next
        if(self.head == nil){
            self.lastRef = nil
        }
        count -= 1
        return val
    }
}

public class Stack<T> where T:Equatable {
    private var top:LNode<T>?
    private var count:Int = 0
    public var length: Int {
        get {
            return count
        }
    }
    
    public var topElement: T? {
        get {
            guard let topElem = self.top else {
                return nil
            }
            return topElem.val
        }
    }
    
    
    public func Push(val:T){
        guard let temp = self.top else{
            self.top = LNode(value: val)
            return
        }
        self.top = LNode(value: val)
        self.top!.next = temp
        count += 1
    }
    
    public func pop() -> T?{
        guard let temp = self.top else{
            return nil
        }
        let next = temp.next
        let val = temp.val
        self.top = next
        count -= 1
        return val
    }
}
