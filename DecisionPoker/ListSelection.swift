//
//  ListSelection.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/30/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import Foundation






var extractedListFromDeckString = ""
var extractedListFromDeckStructure = [Card] ()
var extractedListFromDeckStringArray: [String] = []
var extractedListFromDeckSelectedArray = [""]

var fixedItemInListCounter = 0

// Note: The following variables were created to form a 2D array for the salad results. They will be duplicates of the variables above, but they will create be appended while the variable above will be emptied for each food group. The variables above will then be equalized to the variables below so they can be used in all windows.


var extractedListLocalString = ""
var extractedListLocalStringArray: [String] = []
var extractedListLocalStructure = [[Card] ()]


var extractedFoodGroups: [String] = []




func OutputAndRandomizedArrayWithoutFixedWithSelected(list: [String], number: Int) -> String {
    print(extractedListFromDeckString)
    
    var randomArray = Array (repeating: 1.1, count: list.count)
    if list.count > 1{
        for index in 0...list.count - 1 {
            randomArray[index] = Double.random(in: 1.0...10.0)
        }
        
        let randomArraySorted = randomArray.enumerated().sorted(by: {$0.element > $1.element})
        let indexOfList = randomArraySorted.map{$0.offset}
        // print (indexOfList)
        //print ("\(list.count) listcount")
        let numberCorrected = number - fixedItemInListCounter
        switch numberCorrected {
        case 0:
            //choicesResult += ""
            print("I need a command here!")
        case 1:
            extractedListFromDeckString += list[indexOfList[0]]
            extractedListFromDeckStringArray += [list[indexOfList[0]]]
            
        //choicesResultArray = [stru.listItem[indexOfList[0]]]
        case 2...list.count:
            //choicesResult += "\(list[indexOfList[0]]), "
            for index in 0...numberCorrected - 1 {
                extractedListFromDeckString += "\(list[indexOfList[index]]) "
                extractedListFromDeckStringArray += [list[indexOfList[index]]]
                // choicesResultArray += [stru.listItem[indexOfList[index]]]
            }
            
        default:
            extractedListFromDeckString = "That's too many choices! Either lower the amount of fixed items or lower the total number of items."
            extractedListFromDeckStringArray = ["That's too many choices! Either lower the amount of fixed items or lower the total number of items."]
            
        }

    }
    
    return extractedListFromDeckString

}
