//
//  ViewController.swift
//  Paint
//
//  Created by Macbook on 16.02.18.
//  Copyright © 2018 SDU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var undoButton: UIButton!
    

    @IBAction func colorPressed(_ sender: UIButton) {
        customView.color = sender.tag
    }
    
    @IBAction func shapePressed(_ sender: UIButton) {
        
        customView.identifier = sender.currentTitle!
        
    }
    @IBAction func switchChangeVal(_ sender: UISwitch) {
        if(mySwitch.isOn){
            customView.switcherValue = mySwitch.isOn
        } else {
            customView.switcherValue = mySwitch.isOn
        }
        
    }
  
 override func viewDidLoad() {
        super.viewDidLoad()
        customView.vc = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.TapGest))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.LongGest))

        undoButton.addGestureRecognizer(tapGesture)
        undoButton.addGestureRecognizer(longGesture)
    }
    
    @objc func TapGest() {
        if !customView.shapes.isEmpty{
            customView.shapes.removeLast()
            customView.setNeedsDisplay()
        
        }
    }
    
    @objc func LongGest(){
        if !customView.shapes.isEmpty{
            customView.shapes.removeAll()
            customView.setNeedsDisplay()
            
        }
    }
}



