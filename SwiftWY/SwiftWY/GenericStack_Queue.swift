//
//  GenericStack_Queue.swift
//  SwiftWY
//
//  Created by Venkata Rama Kishore on 31/01/20.
//  Copyright © 2020 Venkata Rama Kishore. All rights reserved.
//

import Foundation

public class LNode<T> {
    var val:T
    var next:LNode?
    init(value:T) {
        self.val = value
    }
}

public class Queue<T> {
    private var head:LNode<T>?
    private var lastRef:LNode<T>?
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
        return val
    }
}

public class Stack<T> {
    private var top:LNode<T>?
    
    public func Push(val:T){
        guard let temp = self.top else{
            self.top = LNode(value: val)
            return
        }
        self.top = LNode(value: val)
        self.top!.next = temp
    }
    
    public func pop() -> T?{
        guard let temp = self.top else{
            return nil
        }
        let next = temp.next
        let val = temp.val
        self.top = next
        return val
    }
}
