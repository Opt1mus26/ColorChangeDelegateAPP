//
//  SettingsViewController.swift
//  colorChangeAPP2
//
//  Created by Павел Цыганов on 24.10.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func changeColorView(for colorVeiw: UIColor)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet var colorVeiw: UIView!
    
    @IBOutlet var colorRedValue: UILabel!
    @IBOutlet var colorGreenValue: UILabel!
    @IBOutlet var colorBlueValue: UILabel!
    
    @IBOutlet var colorRedSlider: UISlider!
    @IBOutlet var colorGreenSlider: UISlider!
    @IBOutlet var colorBlueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var mainViewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorVeiw.backgroundColor = mainViewColor
        
        colorRedSlider.tintColor = .red
        colorGreenSlider.tintColor = .green
        colorBlueSlider.tintColor = .blue
        
        navigationItem.hidesBackButton = true
        colorVeiw.layer.cornerRadius = 20
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        addDoneButtonTo(for: redTextField)
        addDoneButtonTo(for: greenTextField)
        addDoneButtonTo(for: blueTextField)
        
        setSliders()
        changeColorView()
        
        colorRedValue.text = String(round(colorRedSlider.value * 100) / 100)
        colorGreenValue.text = String(round(colorGreenSlider.value * 100) / 100)
        colorBlueValue.text = String(round(colorBlueSlider.value * 100) / 100)
        
        redTextField.text = String(round(colorRedSlider.value * 100) / 100)
        greenTextField.text = String(round(colorGreenSlider.value * 100) / 100)
        blueTextField.text = String(round(colorBlueSlider.value * 100) / 100)
    }
    
    @IBAction func redSliderAction() {
        colorRedValue.text = String(round(colorRedSlider.value * 100) / 100)
        redTextField.text = String(round(colorRedSlider.value * 100) / 100)
        changeColorView()
    }
    
    @IBAction func greenSliderAction() {
        colorGreenValue.text = String(round(colorGreenSlider.value * 100) / 100)
        greenTextField.text = String(round(colorGreenSlider.value * 100) / 100)
        changeColorView()
    }
    
    @IBAction func blueSliderAction() {
        colorBlueValue.text = String(round(colorBlueSlider.value * 100) / 100)
        blueTextField.text = String(round(colorBlueSlider.value * 100) / 100)
        changeColorView()
    }
    
    @IBAction func button() {
        view.endEditing(true)
        changeColorView()
        delegate.changeColorView(for: colorVeiw.backgroundColor ?? .black)
        dismiss(animated: true)
    }
}

extension SettingsViewController {
    private func changeColorView() {
        colorVeiw.backgroundColor = UIColor(red: CGFloat(colorRedSlider.value),
                                            green: CGFloat(colorGreenSlider.value),
                                            blue: CGFloat(colorBlueSlider.value),
                                            alpha: 1)
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: mainViewColor)
        
        colorRedSlider.value = Float(ciColor.red)
        colorGreenSlider.value = Float(ciColor.green)
        colorBlueSlider.value = Float(ciColor.blue)
    }
    
}

extension SettingsViewController {
    private func addDoneButtonTo(for textField: UITextField) {
        
        let numberToolbar = UIToolbar()
        textField.inputAccessoryView = numberToolbar
        numberToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title:"Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        numberToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newTF = textField.text else { return }
        guard let valueTF = Float(newTF), valueTF <= 1.00 else {
            showAlert(title: "Incorrect value!",
                      message: "Please enter a value from 0.01 to 1.00")
            return }
        
        if textField == redTextField {
            colorRedSlider.value = valueTF
        } else if textField == greenTextField {
            colorGreenSlider.value = valueTF
        } else if textField == blueTextField {
            colorBlueSlider.value = valueTF
        }
        
        colorRedValue.text = String(round(colorRedSlider.value * 100) / 100)
        colorGreenValue.text = String(round(colorGreenSlider.value * 100) / 100)
        colorBlueValue.text = String(round(colorBlueSlider.value * 100) / 100)
        
        changeColorView()
    }
}
