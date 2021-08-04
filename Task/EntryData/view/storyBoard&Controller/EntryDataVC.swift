//
//  EntryDataVC.swift
//  Task
//
//  Created by Ahmed on 8/3/21.
//

import UIKit
import RealmSwift

class EntryDataVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var describtionTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //var imageData:Data?
    var imgData = NSData()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        design()
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EntryDataVC.imageTapped(gesture:)))
        
        // add it to the image view;
        image.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        image.isUserInteractionEnabled = true
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
            // if the tapped view is a UIImageView then set it to imageview
            if (gesture.view as? UIImageView) != nil {
                print("Image Tapped")
                presentInputActionSheet()
            }
        }
    
    private func design() {
        
        image.layer.cornerRadius = 10
        image.layer.shadowColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        image.layer.shadowOffset = CGSize(width: 0, height: 2)
        image.layer.shadowRadius = 2
        image.layer.shadowOpacity = 0.3
        
        nameTF.layer.cornerRadius = 10
        describtionTF.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        let newAppData = AppData()
        guard let name = nameTF.text, let desc = describtionTF.text, !name.isEmpty, !desc.isEmpty else { return }
        
        let datta = image.image
        let dattta = image.image?.jpegData(compressionQuality: 0.50)
        print(dattta!)
        let dattImage = datta?.pngData()
        print(dattImage!)
        
        realm.beginWrite()
        newAppData.name = name
        newAppData.desc = desc
        if let data = dattImage as Data? {
            newAppData.photoData = data as Data
        }
        realm.add(newAppData)
        try! realm.commitWrite()
        
        navigationController?.popViewController(animated: true)
        
    }
    
}


