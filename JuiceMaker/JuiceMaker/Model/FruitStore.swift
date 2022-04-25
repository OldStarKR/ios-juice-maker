//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

// 과일 저장소 타입
class FruitStore {
    var stock: Dictionary<FruitKind, Int> =
    [FruitKind.strawberry: 10,
     FruitKind.banana: 10,
     FruitKind.kiwi: 10,
     FruitKind.pineaple : 10,
     FruitKind.mango: 10]
    
    func changeFruitAmount(fruitName: FruitKind, amount: Int) {
        stock[fruitName] = amount
    }
    
    func subtractFruitAmount(fruitName: FruitKind, amount: Int) {
        if let fruit = stock[fruitName] {
            stock[fruitName] = fruit - amount
        }
    }
    
    func addFruitAmount(fruitName: FruitKind, amount: Int) {
        if let fruit = stock[fruitName] {
            stock[fruitName] = fruit + amount
        }
    }
}
