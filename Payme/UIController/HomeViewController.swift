//
//  HomeControllerViewController.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/22/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit
import CoreData

class HomeControllerViewController: UIViewController,UITableViewDataSource ,GeneralLoading, ManageObjectContextDependentType{
 
    
    
    @IBOutlet var tableView: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    //NSFetchedResultsControllerDelegate
   
    
    var testmen = ""
 
    
    var presenter : HomePresenter!
    
    var dataRequest : [Request]?

    @IBOutlet weak var txt_description: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()


        
        tableView.dataSource  = self
        

    }
    

    

    

    
    func Loading() {
         
     }
     
     func LoadingFail(msg: String) {
         
     }
     
     func LoadingSuccessfull(msg: String) {
        
       FetchData()
     }
     
     
    func FetchData(){
         let data =  NSFetchRequest<Request>(entityName: Request.entityName)
         do{
             data.returnsObjectsAsFaults = false
             dataRequest = try managedObjectContext.fetch(data)
            
            tableView.reloadData()
              //print("Oga na me be this \(dataResult)")
         }catch{
             print("Errors \(error)")
         }
     }
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRequest?.count ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
        
        cell.pendReq = dataRequest?[indexPath.row]
        return cell
     }
     
     
     
     
     
//     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//               if let sections = self.fetchedResultsController.sections{
//
//
//                 return sections[section].numberOfObjects
//
//             }
//
//        return 0
//     }
//
//     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
//
//
//
//
//        let pendReq = self.fetchedResultsController?.object(at: indexPath)
//
//        cell.pendReq = pendReq
//        print("nam mr oo \(String(describing: pendReq)))")
//
//       return cell
//     }
    
    
    override func viewDidAppear(_ animated: Bool) {
        presenter = HomePresenter(callBack: self)
        presenter.getRequest(mainContext: self.managedObjectContext)
        
        
        
    }
    
    
    
 

}
