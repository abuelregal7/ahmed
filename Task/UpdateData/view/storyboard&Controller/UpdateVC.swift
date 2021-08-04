//
//  UpdateVC.swift
//  Task
//
//  Created by Ahmed on 8/3/21.
//

import UIKit
import RealmSwift

class UpdateVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var updateButtonOutlet: UIButton!
    
    let realm = try! Realm()
    
    static var appData : AppData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EntryDataVC.imageTapped(gesture:)))
        
        // add it to the image view;
        image.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        image.isUserInteractionEnabled = true
        
        image.layer.cornerRadius = 10
        image.layer.shadowColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        image.layer.shadowOffset = CGSize(width: 0, height: 2)
        image.layer.shadowRadius = 2
        image.layer.shadowOpacity = 0.3
        
        nameTF.layer.cornerRadius = 10
        descriptionTF.layer.cornerRadius = 10
        updateButtonOutlet.layer.cornerRadius = 10
        
        if let data = UpdateVC.appData.photoData as Data?  {
            image.image = UIImage(data: data as Data)
        }
        nameTF.text = UpdateVC.appData.name
        descriptionTF.text = UpdateVC.appData.desc
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            presentInputActionSheet()
        }
    }
    
    @IBAction func updateButtonAction(_ sender: Any) {
        
        //            if let data = dattImage as Data? {
        //                result.first?.photoData = dattImage
        //            }
        
        let datta = image.image
        let dattta = image.image?.jpegData(compressionQuality: 0.50)
        print(dattta!)
        let dattImage = datta?.pngData()
        print(dattImage!)
        
        realm.beginWrite()
        let result = realm.objects(AppData.self).filter("name == '\(UpdateVC.appData.name!)'")
        result.first?.name = nameTF.text
        result.first?.desc = descriptionTF.text
        result.first?.photoData = datta?.pngData()

        try! realm.commitWrite()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
}


