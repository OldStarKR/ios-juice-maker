//
//  stockViewController.swift
//  JuiceMaker
//
//  Created by unchain, kiwi on 2022/05/02.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var strawberryStock: UILabel!
    @IBOutlet weak var bananaStock: UILabel!
    @IBOutlet weak var pineappleStock: UILabel!
    @IBOutlet weak var kiwiStock: UILabel!
    @IBOutlet weak var mangoStock: UILabel!
    
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupStepper()
    }
    
    @IBAction func didTapClosedStockViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    func setupViews() {
        strawberryStock.text = FruitStore.shared.showFruitsStock(name: .strawberry)
        bananaStock.text = FruitStore.shared.showFruitsStock(name: .banana)
        pineappleStock.text = FruitStore.shared.showFruitsStock(name: .pineapple)
        kiwiStock.text = FruitStore.shared.showFruitsStock(name: .kiwi)
        mangoStock.text = FruitStore.shared.showFruitsStock(name: .mango)
    }
    
    func findFruitStepper(stepper: UIStepper) throws -> Fruits {
        switch stepper {
        case strawberryStepper:
            return .strawberry
        case bananaStepper:
            return .banana
        case pineappleStepper:
            return .pineapple
        case kiwiStepper:
            return .kiwi
        case mangoStepper:
            return .mango
        default:
            throw FruitStoreError.wrongMenu
        }
    }
    
    func setupStepper() {
        strawberryStepper.value = Double(makeVaildStepperValue(fruit: .strawberry))
        bananaStepper.value = Double(makeVaildStepperValue(fruit: .banana))
        pineappleStepper.value = Double(makeVaildStepperValue(fruit: .pineapple))
        kiwiStepper.value = Double(makeVaildStepperValue(fruit: .kiwi))
        mangoStepper.value = Double(makeVaildStepperValue(fruit: .mango))
    }
    
    func makeVaildStepperValue(fruit: Fruits) -> Int {
        guard let stepperValue = FruitStore.shared.fruits[fruit] else { return -1 }
        return stepperValue
    }
    
    private func selectFruitLable(fruit: Fruits) -> UILabel {
        switch fruit {
        case .strawberry:
            return strawberryStock
        case .mango:
            return mangoStock
        case .kiwi:
            return kiwiStock
        case .pineapple:
            return pineappleStock
        case .banana:
            return bananaStock
        }
    }
}
