//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

struct JuiceMaker {
    private let store = FruitStore()
        
    func make(menu: Menu) throws {
        guard store.hasFruit(menu: menu) else {
            throw JuiceMakerError.lackOfStock
        }
        store.decreaseStock(menu: menu)
    }
    
    func transferFruitStock() {
        return store.transferFruitStockToJuiceMaker()
    }
}
