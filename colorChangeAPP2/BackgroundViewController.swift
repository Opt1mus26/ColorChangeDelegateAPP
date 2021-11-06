//
//  BackgroundViewController.swift
//  colorChangeAPP2
//
//  Created by Павел Цыганов on 05.11.2021.
//

import UIKit

class BackgroundViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let backgroundVC = segue.destination as? SettingsViewController else { return }
        backgroundVC.delegate = self
        backgroundVC.mainViewColor = view.backgroundColor
    }
}

extension BackgroundViewController: SettingsViewControllerDelegate {
    func changeColorView(for colorView: UIColor) {
        view.backgroundColor = colorView
    }
}


