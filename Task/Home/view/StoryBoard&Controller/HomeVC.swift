//
//  HomeVC.swift
//  Task
//
//  Created by Ahmed on 8/3/21.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {

    @IBOutlet weak var homeTableViewOutlet: UITableView!
    
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet weak var addButtonBarItemOutlet: UIBarButtonItem!
    
    let  realm = try! Realm()
    var result : Results<AppData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        workWithButtonShadow()
        
        homeTableViewOutlet.delegate = self
        homeTableViewOutlet.dataSource = self
        
        getData()
        print(result!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeTableViewOutlet.reloadData()
        print(result!)
    }
    
    func getData() {
        
        realm.beginWrite()
        result = realm.objects(AppData.self)
        try! realm.commitWrite()
        
    }
    
    private func workWithButtonShadow() {
        addButtonOutlet.layer.cornerRadius = 20
        addButtonOutlet.layer.shadowColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        addButtonOutlet.layer.shadowOffset = CGSize(width: 0, height: 2)
        addButtonOutlet.layer.shadowRadius = 2
        addButtonOutlet.layer.shadowOpacity = 0.3
        addButtonOutlet.pulsate()
    }
    
    @IBAction func addButtonBarItemAction(_ sender: Any) {
        
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "EntryDataVC") as! EntryDataVC
        navigationController?.pushViewController (viewcontroller, animated: true)
        
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "EntryDataVC") as! EntryDataVC
        navigationController?.pushViewController (viewcontroller, animated: true)
        
    }
    
    private func deleteData(_ data: AppData) {
        
        realm.beginWrite()
        realm.delete(data)
        try! realm.commitWrite()
        homeTableViewOutlet.reloadData()
        
        
    }
    private func editData(_ data: AppData) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC  = storyboard.instantiateViewController(withIdentifier: "UpdateVC") as! UpdateVC
        
        navigationController?.pushViewController (VC, animated: true)
        UpdateVC.appData = data
        
    }
    
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableViewOutlet.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = result[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeTableViewOutlet.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = result[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, sourceView, completionHandler) in
            guard let self = self else { return }
            print("index path of delete: \(indexPath)")
            self.deleteData(item)
            completionHandler(true)
        }
        let rename = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, sourceView, completionHandler) in
            guard let self = self else { return }
            print("index path of edit: \(indexPath)")
            self.editData(item)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [rename, delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
}
