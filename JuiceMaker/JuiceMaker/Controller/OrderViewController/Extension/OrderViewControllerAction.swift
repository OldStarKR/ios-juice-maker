//
//  OrderViewControllerAction.swift
//  JuiceMaker
//
//  Created by HyeJee Kim on 2022/02/16.
//

import UIKit

extension OrderViewController {
    
    @IBAction func touchStrawberryBananaJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .strawberryBananaJuice)
    }
    
    @IBAction func touchMangoKiwiJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .mangoKiwiJuice)
    }
    
    @IBAction func touchStrawberryJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .strawberryJuice)
    }
    
    @IBAction func touchBananaJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .bananaJuice)
    }
    
    @IBAction func touchPinappleJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .pineappleJuice)
    }
    
    @IBAction func touchKiwiJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .kiwiJuice)
    }
    
    @IBAction func touchMangoJuiceOrderButton(_ sender: Any) {
        orderJuice(menu: .mangoJuice)
    }
    
    private func orderJuice(menu: Juice) {
        juiceMaker.makeJuice(of: menu, result: { result in
            switch result {
            case .success:
                let orderResultAlertController: UIAlertController = UIAlertController(title: "\(menu.name) 나왔습니다! 맛있게 드세요!", message: nil, preferredStyle: .alert)
                let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                orderResultAlertController.addAction(okAction)
                present(orderResultAlertController, animated: true, completion: nil)
            case .fail(let error):
                var errorMessage: String?
                if let fruitStoreError: FruitStoreError = error as? FruitStoreError {
                    errorMessage = fruitStoreError.errorDescription
                }
                else if let juiceMakerError: JuiceMakerError = error as? JuiceMakerError {
                    errorMessage = juiceMakerError.errorDescription
                }
                
                let orderResultAlertController: UIAlertController = UIAlertController(title: "재고가 모자라요. 재고를 수정할까요?", message: errorMessage, preferredStyle: .alert)
                let yesAction: UIAlertAction = UIAlertAction(title: "예", style: .default, handler: nil)
                orderResultAlertController.addAction(yesAction)
                let noAction: UIAlertAction = UIAlertAction(title: "아니오", style: .destructive, handler: nil)
                orderResultAlertController.addAction(noAction)
                present(orderResultAlertController, animated: true, completion: nil)
            }
        })
    }
    
}
