//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

struct JuiceMaker {
    private let fruitStore = FruitStore(stock: 10)
    
    var fruitsInStock: Fruits {
        fruitStore.fruits
    }
    
    func make(_ menu: FruitJuice) -> Result<FruitJuice, FruitError> {
        let result = fruitStore.pickUpFruits(for: menu)
        return result
    }
}
