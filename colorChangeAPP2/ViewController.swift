//
//  ViewController.swift
//  colorChangeAPP2
//
//  Created by Павел Цыганов on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorVeiw: UIView!
    
    @IBOutlet var colorRedValue: UILabel!
    @IBOutlet var colorGreenValue: UILabel!
    @IBOutlet var colorBlueValue: UILabel!
    
    @IBOutlet var colorRedSlider: UISlider!
    @IBOutlet var colorGreenSlider: UISlider!
    @IBOutlet var colorBlueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRedValue.text = String(colorRedSlider.value)
        colorGreenValue.text = String(colorGreenSlider.value)
        colorBlueValue.text = String(colorBlueSlider.value)
        
        colorVeiw.backgroundColor = .black
    }

    @IBAction func redSliderAction() {
        colorRedValue.text = String(round(colorRedSlider.value * 100) / 100)
        changeColorView()
    }
    @IBAction func greenSliderAction() {
        colorGreenValue.text = String(round(colorGreenSlider.value * 100) / 100)
        changeColorView()
    }
    @IBAction func blueSliderAction() {
        colorBlueValue.text = String(round(colorBlueSlider.value * 100) / 100)
        changeColorView()
    }
    private func changeColorView() {
        colorVeiw.backgroundColor = UIColor(red: CGFloat(colorRedSlider.value),
                                            green: CGFloat(colorGreenSlider.value),
                                            blue: CGFloat(colorBlueSlider.value),
                                            alpha: 1)
    }
    
}

