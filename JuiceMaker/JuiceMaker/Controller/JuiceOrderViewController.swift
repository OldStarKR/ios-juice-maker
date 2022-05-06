//
//  JuiceMaker - JuiceOrderViewController.swift
//  Created by 수꿍, 바드. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

let center = NotificationCenter.default

class JuiceOrderViewController: UIViewController {
    @IBOutlet private weak var strawberryLabel: UILabel!
    @IBOutlet private weak var bananaLabel: UILabel!
    @IBOutlet private weak var pineappleLabel: UILabel!
    @IBOutlet private weak var kiwiLabel: UILabel!
    @IBOutlet private weak var mangoLabel: UILabel!
    
    let juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFruitStock()
        observeStockChanges()
    }

    private func showFruitStock() {
        strawberryLabel.text = String(juiceMaker.fruitStore.fruitWarehouse[.strawberry] ?? 0)
        bananaLabel.text = String(juiceMaker.fruitStore.fruitWarehouse[.banana] ?? 0)
        pineappleLabel.text = String(juiceMaker.fruitStore.fruitWarehouse[.pineapple] ?? 0)
        kiwiLabel.text = String(juiceMaker.fruitStore.fruitWarehouse[.kiwi] ?? 0)
        mangoLabel.text = String(juiceMaker.fruitStore.fruitWarehouse[.mango] ?? 0)
    }
    
    @IBAction private func makeJuice(_ sender: UIButton) {
        var juice: Juice {
            switch sender.currentTitle {
            case "딸기쥬스 주문":
                return .strawberry
            case "바나나쥬스 주문":
                return .banana
            case "파인애플쥬스 주문":
                return .pineapple
            case "키위쥬스 주문":
                return .kiwi
            case "딸바쥬스 주문":
                return .strawberryBanana
            case "망고쥬스 주문":
                return .mango
            case "망키쥬스 주문":
                return .mangoKiwi
            default:
                return .unknownFruit
            }
        }
        
        tryMaking(juice)
        showFruitStock()
    }
    
    private func tryMaking(_ juice: Juice) {
        do {
            try juiceMaker.make(juice)
            showSuccessAlert(juice)
        } catch FruitStoreError.outOfStock {
            showFailAlert()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func showSuccessAlert(_ juice: Juice) {
        let successAlert = UIAlertController(title: "\(juice.name) 쥬스 나왔습니다!\n 맛있게 드세요!", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)

        successAlert.addAction(ok)
        present(successAlert, animated: true)
    }
    
    private func showFailAlert() {
        let failAlert = UIAlertController(title: "재료가 모자라요.\n 재고를 수정할까요?", message: nil, preferredStyle: .alert)
        let no = UIAlertAction(title: "아니오", style: .cancel)
        let yes = UIAlertAction(title: "예", style: .default) { action in
            self.goToFruitStockViewController()
        }
        
        failAlert.addAction(no)
        failAlert.addAction(yes)
        present(failAlert, animated: true)
    }
    
    @IBAction private func navigationRightButtonTapped(_ sender: UIBarButtonItem) {
        goToFruitStockViewController()
    }
    
    private func goToFruitStockViewController() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ModalViewController") else { return }
        
        dispatchFruitLabel()
        present(controller, animated: true)
    }
    
    private func dispatchFruitLabel() {
        FruitStockViewController.numberOfStrawberry = strawberryLabel.text ?? ""
        FruitStockViewController.numberOfBanana = bananaLabel.text ?? ""
        FruitStockViewController.numberOfPineapple = pineappleLabel.text ?? ""
        FruitStockViewController.numberOfKiwi = kiwiLabel.text ?? ""
        FruitStockViewController.numberOfMango = mangoLabel.text ?? ""
    }
    
    private func observeStockChanges() {
        center.addObserver(self, selector: #selector(updateFruitStock), name: .checkFruitStock, object: nil)
    }
    
    @objc private func updateFruitStock() {
        tryUpdateFruitStock()
        showFruitStock()
    }
    
    private func tryUpdateFruitStock() {
        try? juiceMaker.fruitStore.changeStock(fruit: .strawberry, amount: Int(FruitStockViewController.numberOfStrawberry) ?? 0)
        try? juiceMaker.fruitStore.changeStock(fruit: .banana, amount: Int(FruitStockViewController.numberOfBanana) ?? 0)
        try? juiceMaker.fruitStore.changeStock(fruit: .pineapple, amount: Int(FruitStockViewController.numberOfPineapple) ?? 0)
        try? juiceMaker.fruitStore.changeStock(fruit: .kiwi, amount: Int(FruitStockViewController.numberOfKiwi) ?? 0)
        try? juiceMaker.fruitStore.changeStock(fruit: .mango, amount: Int(FruitStockViewController.numberOfMango) ?? 0)
    }
}

extension Notification.Name {
    static let checkFruitStock = Notification.Name("checkFruitStock")
}
