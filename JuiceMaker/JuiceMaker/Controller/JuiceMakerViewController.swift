//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class JuiceMakerViewController: UIViewController {
    private var juiceMaker = JuiceMaker()
    
    @IBOutlet private weak var strawberryStockLabel: UILabel!
    @IBOutlet private weak var bananaStockLabel: UILabel!
    @IBOutlet private weak var pineappleStockLabel: UILabel!
    @IBOutlet private weak var kiwiStockLabel: UILabel!
    @IBOutlet private weak var mangoStockLabel: UILabel!
    
    @IBOutlet private weak var strawberryAndBananaJuiceButton: UIButton!
    @IBOutlet private weak var mangoAndKiwiJuiceButton: UIButton!
    @IBOutlet private weak var strawberryJuiceButton: UIButton!
    @IBOutlet private weak var bananaJuiceButton: UIButton!
    @IBOutlet private weak var pineappleJuiceButton: UIButton!
    @IBOutlet private weak var kiwiJuiceButton: UIButton!
    @IBOutlet private weak var mangoJuiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverFruitsStockDidChanged()
        updateFruitsStockLabels(juiceMaker.requestCurrentStock())
    }
    
    @IBAction private func orderFruitJuice(_ sender: UIButton) {
        switch sender {
        case strawberryAndBananaJuiceButton:
            respondOrder(of: .strawberryAndBananaJuice)
        case strawberryJuiceButton:
            respondOrder(of: .strawberryJuice)
        case bananaJuiceButton:
            respondOrder(of: .bananaJuice)
        case pineappleJuiceButton:
            respondOrder(of: .pineappleJuice)
        case kiwiJuiceButton:
            respondOrder(of: .kiwiJuice)
        case mangoJuiceButton:
            respondOrder(of: .mangoJuice)
        case mangoAndKiwiJuiceButton:
            respondOrder(of: .mangoAndKiwiJuice)
        default:
            break
        }
    }
    
    private func addObserverFruitsStockDidChanged() {
        NotificationCenter.default.addObserver(forName: NotificationName.fruitsStockDidChanged, object: nil , queue: nil) { Notification in
            guard let changedFruitsStock = Notification.userInfo as? [Fruit:Int]? else {
                return
            }
            self.updateFruitsStockLabels(changedFruitsStock)
        }
    }
    
    private func respondOrder(of fruitjuice: FruitJuice) {
        do {
            let orderResult = try juiceMaker.takeOrder(fruitjuice)
            switch orderResult {
            case .failure(JuiceMakerError.productionImpossibleError):
                alertfailureOfFruitJuice()
            case .success(let fruitJuice):
                alertSuccess(of: fruitJuice)
            }
        } catch {
            alertInvalidAccess()
        }
    }
    
    private func alertSuccess(of fruitJuice: FruitJuice) {
        let alert = UIAlertController(title: nil, message: "\(fruitJuice.rawValue) 나왔습니다! 맛있게 드세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func alertfailureOfFruitJuice() {
        let alert = UIAlertController(title: nil, message: "재료가 모자라요. 재고를 수정할까요?", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "예", style: .default) { UIAlertAction in
            self.presentModalViewController(withId: "FruitStoreViewController")
        }
        let noAction = UIAlertAction(title: "아니오", style: .default)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
    
    private func alertInvalidAccess() {
        let alert = UIAlertController(title: nil, message: "잘못된 접근입니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func presentModalViewController(withId: String) {
        guard let modalViewController = storyboard?.instantiateViewController(withIdentifier: withId) else {
            return
        }
        present(modalViewController, animated: true)
    }
    
    private func updateFruitsStockLabels(_ stock: [Fruit:Int]?) {
        _ = stock?.compactMap { (key: Fruit, value: Int) in
            modifyFruitStockLabel(key.rawValue, value)
        }
    }
    
    private func modifyFruitStockLabel(_ fruit: String, _ stock: Int) {
        let allStockLabels: [UILabel] = [strawberryStockLabel, bananaStockLabel, pineappleStockLabel, kiwiStockLabel, mangoStockLabel]
        for uiLabel in allStockLabels.filter({ $0.accessibilityIdentifier == fruit }) {
            uiLabel.text = String(stock)
        }
    }
}
