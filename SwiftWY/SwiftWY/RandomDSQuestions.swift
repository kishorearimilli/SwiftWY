//
//  RandomDSQuestions.swift
//  SwiftWY
//
//  Created by Venkata Rama Kishore Arimilli on 25/03/22.
//  Copyright © 2022 Venkata Rama Kishore. All rights reserved.
//

import Foundation

class RandomDSQuestions {
    
    //Rotten Oranges - print min time taken to Rot all the Oranges. If it isn't possible return -1 (all four sides have zeros)
    // https://leetcode.com/problems/rotting-oranges/
    private struct ArrayPosition:Equatable {
        var r:Int
        var c:Int
    }
    
    private class func isValidIndexPosition(r:Int,c:Int, ip:[[Int]]) -> Bool {
        let rc = ip.count
        let cc = ip[0].count
        return r >= 0 && r < rc && c >= 0 && c < cc
    }
    
    class func rottenOrangesTimeFrame(ip: inout [[Int]]) -> Int {
        //Assumed ip only 2d Array
        let rotOrangesTrack = Queue<ArrayPosition>()
        let rotOrangesTempTrack = Queue<ArrayPosition>()
        let rotOrangesTimeSlab = Queue<ArrayPosition>()
        var totalTimeFrames = 0
        let rc = ip.count
        let cc = ip[0].count
        var totalCount = 0
        for rowIdx in 0..<rc {
            for colIdx in 0..<cc {
                if ip[rowIdx][colIdx] == 1 {
                    rotOrangesTrack.Enqueue(val: ArrayPosition(r: rowIdx, c: colIdx))
                }
            }
        }
        if (rotOrangesTrack.length <= 0) {
            return totalTimeFrames
        }
        totalCount = rotOrangesTrack.length
        while true {
            while rotOrangesTrack.length > 0 {
                let newElem = rotOrangesTrack.Dequeue()!
                let rowChanges = [0,1,-1,0]
                let colChanges = [1,0,0,-1]
                var isBoundedByZero = true
                var isBoundedByOne = true
                outerLoop: for tr in 0...3 {
                    let nextIndex = (newElem.r+rowChanges[tr],newElem.c+colChanges[tr])
                    if (isValidIndexPosition(r: nextIndex.0, c: nextIndex.1, ip: ip)) {
                        if (ip[nextIndex.0][nextIndex.1] == 2) {
                            rotOrangesTempTrack.Enqueue(val: newElem)
                            isBoundedByZero = false
                            isBoundedByOne = false
                            break outerLoop
                        } else if (ip[nextIndex.0][nextIndex.1] == 0) {
                             isBoundedByZero = (isBoundedByZero && true)
                        } else if (ip[nextIndex.0][nextIndex.1] == 1) {
                            isBoundedByZero = false
                            isBoundedByOne = (isBoundedByOne && true)
                        }
                    }
                }
                if isBoundedByZero {
                    return -1
                }
                if isBoundedByOne {
                    rotOrangesTimeSlab.Enqueue(val: newElem)
                }
                
            }
            while rotOrangesTempTrack.length > 0 {
                let rotOrange = rotOrangesTempTrack.Dequeue()!
                ip[rotOrange.r][rotOrange.c] = 2
            }
            //Edge case where Oranges can't be rotten because of surrounded by all zero's or ones's only
            if (rotOrangesTimeSlab.length >= totalCount) {
                return -1
            }
            while rotOrangesTimeSlab.length > 0 {
                rotOrangesTrack.Enqueue(val: rotOrangesTimeSlab.Dequeue()!)
            }
            totalCount = rotOrangesTrack.length
            totalTimeFrames +=  1
            if rotOrangesTrack.length == 0 {
                break
            }
        }
        return totalTimeFrames
    }
}
