//
//  BulbCollectionViewCell.swift
//  Sparsha
//
//  Created by Hem Poudyal on 3/30/21.
//

import UIKit

class BulbCollectionViewCell: UICollectionViewCell{
    var lights = ["CandleLight", "Sunset", "Warm", "DayLight"]
    var lightColors = ["#EA7F3B", "#E2AB6F", "#EDE1D1", "#FFFBFB"]
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    func configureCell(selectedRow: Int){
        lightLabel.text = lights[selectedRow]
        bgView.backgroundColor = UIColor.init(hexString: lightColors[selectedRow])
        bgView.layer.cornerRadius = 10.0
        bgView.layer.masksToBounds = true
        
        if selectedRow < 2 {
            lightLabel.textColor = UIColor.init(hexString: "#F5F1F0")
        } else {
            lightLabel.textColor = UIColor.init(hexString: "#575555")
        }
    }
}
