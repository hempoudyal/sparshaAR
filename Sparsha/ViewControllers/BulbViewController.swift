//
//  BulbViewController.swift
//  Sparsha
//
//  Created by Hem Poudyal on 3/30/21.
//

import UIKit

class BulbViewController: UIViewController{
    
    @IBOutlet weak var txtKelvinInput: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bgView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
    }
    
    @IBAction func sendInput(_ sender: Any) {
        if txtKelvinInput.text?.isEmpty ?? true {
            return
        } else {
            let param : [String: Any] = ["color": "white kelvin:" + txtKelvinInput.text!]
            print(param)
            requestData(param: param)
        }
    }
    
    func requestData(param: [String: Any]){
        WebService.webRequest(.state, parameters: param) { (response) in
            print(response)
        } failureBlock: { (msg) in
            print(msg)
        }
    }
}

//Setup CollectionView
extension BulbViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BulbCollectionViewCell
        cell.configureCell(selectedRow: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kelvinLightValue: [Int: Int] = [0: 1500,
                                            1: 2000,
                                            2: 3000,
                                            3: 6000]
        let param: [String: Any] = ["color": "white kelvin:" + String(kelvinLightValue[indexPath.row]!)]
        print(param)
        requestData(param: param)
    }
}

extension BulbViewController:  UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Give cell width and height
        let screenRect = UIScreen.main.bounds
        let cellwidth = ((screenRect.size.width/2) - 75)
        let cellHeight = cellwidth
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Set Edge Insets
        return UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        // splace between two cell vertically
        return 20
    }
}
