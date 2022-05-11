//
//  StoreViewController.swift
//  JuiceMaker
//
//  Created by 이원빈 on 2022/05/02.
//

import UIKit

final class StoreViewController: UIViewController {
    @IBOutlet private weak var strawberryLabel: UILabel?
    @IBOutlet private weak var bananaLabel: UILabel?
    @IBOutlet private weak var pineappleLabel: UILabel?
    @IBOutlet private weak var kiwiLabel: UILabel?
    @IBOutlet private weak var mangoLabel: UILabel?
    
    @IBOutlet private weak var strawberryStepper: UIStepper?
    @IBOutlet private weak var bananaStepper: UIStepper?
    @IBOutlet private weak var pineappleStepper: UIStepper?
    @IBOutlet private weak var kiwiStepper: UIStepper?
    @IBOutlet private weak var mangoStepper: UIStepper?
    
    private var fruits: FruitStock?
    var delegate: ManangingOrderDelegate?
    var fruits: FruitStock = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fruits = self.delegate?.setUpStock()
        self.updateStepperDefaultValue()
        self.updateStepperDefaultValue(with: fruits)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
}

private extension StoreViewController {
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.delegate?.updateUI()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stepperButtonDidTapped(_ sender: UIStepper) {
        switch sender {
        case strawberryStepper:
            strawberryLabel.text = strawberryStepper.descriptionValue()
            self.delegate?.edit(fruit: .strawberry, with: strawberryStepper.convertInt())
        case bananaStepper:
            bananaLabel.text = bananaStepper.descriptionValue()
            self.delegate?.edit(fruit: .banana, with: bananaStepper.convertInt())
        case pineappleStepper:
            pineappleLabel.text = pineappleStepper.descriptionValue()
            self.delegate?.edit(fruit: .pineapple, with: pineappleStepper.convertInt())
        case kiwiStepper:
            kiwiLabel.text = kiwiStepper.descriptionValue()
            self.delegate?.edit(fruit: .kiwi, with: kiwiStepper.convertInt())
        case mangoStepper:
            mangoLabel.text = mangoStepper.descriptionValue()
            self.delegate?.edit(fruit: .mango, with: mangoStepper.convertInt())
        default:
            return
        }
    }
}

private extension StoreViewController {
    func updateStepperDefaultValue(with fruits: FruitStock) {
        self.strawberryStepper?.value = Double(fruits[.strawberry] ?? 0)
        self.bananaStepper?.value = Double(fruits[.banana] ?? 0)
        self.pineappleStepper?.value = Double(fruits[.pineapple] ?? 0)
        self.kiwiStepper?.value = Double(fruits[.kiwi] ?? 0)
        self.mangoStepper?.value = Double(fruits[.mango] ?? 0)
    }
    
    func updateUI() {
        self.strawberryLabel?.text = self.strawberryStepper?.descriptionValue()
        self.bananaLabel?.text = self.bananaStepper?.descriptionValue()
        self.pineappleLabel?.text = self.pineappleStepper?.descriptionValue()
        self.kiwiLabel?.text = self.kiwiStepper?.descriptionValue()
        self.mangoLabel?.text = self.mangoStepper?.descriptionValue()
    }
}

private extension UIStepper {
    func descriptionValue() -> String {
        return intValue().description
    }
}
