//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

class FruitStore {
    private var stock: [Fruit: Int] = [.strawberry: 10, .banana: 10, .pineapple: 10, .kiwi: 10, .mango: 10]
    
    private func hasFruit(menu: Menu, total: Int) -> Bool {
        let necessaryFruit = menu.count(to: total)
        
        for (fruit, need) in necessaryFruit {
            guard let number = stock[fruit] else { continue }
            if number < need {
                return false
            }
        }
        return true
    }
    
    func decreaseStock(total: Int, menu: Menu) throws {
        let necessaryFruit = menu.count(to: total)
        
        for (fruit, need) in necessaryFruit {
            guard hasFruit(menu: menu, total: total) else {
                throw JuiceMakerError.lackOfStock
            }
            
            guard let number = stock[fruit] else {
                return
            }
            
            stock[fruit] = number - (need * total)
        }
    }
    
    func fillStock(fruit: Fruit, total: Int) {
        guard let number = stock[fruit] else { return }
        stock[fruit] = number + total
    }
}
