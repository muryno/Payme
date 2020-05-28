//
//  HomeControllerViewController.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/22/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit
import CoreData

class HomeControllerViewController: UITableViewController ,GeneralLoading, ManageObjectContextDependentType, NSFetchedResultsControllerDelegate{
    
    var managedObjectContext: NSManagedObjectContext!
    
   
    
    var testmen = ""
 
    
    var presenter : HomePresenter!

    @IBOutlet weak var txt_description: UITextView!
    
    var fetchedResultsController: NSFetchedResultsController<Request>!

    override func viewDidLoad() {
        super.viewDidLoad()

       //NotificationCenter.default.post(name: NSNotification.Name("MakeRequest"), object: nil)
       configureFetchedResultsController()
        

    }
    

    
    //
    func configureFetchedResultsController()  {
            let paymentFetchRequest = NSFetchRequest<Request>(entityName: Request.entityName)
        let departmentSortDescriptor = NSSortDescriptor(key: #keyPath(Request.id), ascending: false)
          
             paymentFetchRequest.sortDescriptors = [departmentSortDescriptor]
         
         
         self.fetchedResultsController = NSFetchedResultsController<Request>(fetchRequest: paymentFetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
         
        
        self.fetchedResultsController.delegate = self
        
        
        
          do {
              try self.fetchedResultsController.performFetch()
              
             
                     
              } catch {
                  let alertController = UIAlertController(title: "Loading Request Failed",
                                                          message: "There was a problem loading the list of Pending Request. Please try again.",
                                                          preferredStyle: .alert)
                  
                  let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                  alertController.addAction(okAction)
                  self.present(alertController, animated: true, completion: nil)
              }
     }
    
    
    

    
    func Loading() {
         
     }
     
     func LoadingFail(msg: String) {
         
     }
     
     func LoadingSuccessfull(msg: String) {
        
     }
     
     
     
     
     
     
     
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               if let sections = self.fetchedResultsController.sections{
                
          
                 return sections[section].numberOfObjects
              
             }

        return 0
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
         
         
     
        
        let pendReq = self.fetchedResultsController?.object(at: indexPath)
         
        cell.pendReq = pendReq
        print("nam mr oo \(String(describing: pendReq)))")
       
       return cell
     }
    
    
    override func viewDidAppear(_ animated: Bool) {
        presenter = HomePresenter(callBack: self)
        presenter.getRequest(mainContext: self.managedObjectContext)
    }
    
    
    
    // MARK: -NSFetchedResultsController Delegate methods
     func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         self.tableView.beginUpdates()
     }
     
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         self.tableView.endUpdates()
     }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                     didChange anObject: Any,
                     at indexPath: IndexPath?,
                     for type: NSFetchedResultsChangeType,
                     newIndexPath: IndexPath?) {
         switch type {
         case .insert:
             if let insertIndexPath = newIndexPath {
                 self.tableView.insertRows(at: [insertIndexPath], with: .fade)
             }
         case .delete:
             if let deleteIndexPath = indexPath {
                 self.tableView.deleteRows(at: [deleteIndexPath], with: .fade)
             }
         case .update:
             if let updateIndexPath = indexPath {
//                 let cell = self.tableView.cellForRow(at: updateIndexPath)
//                 let updatedShoutOut = self.fetchedResultsController.object(at: updateIndexPath)
//
               
             }
         case .move:
             if let deleteIndexPath = indexPath {
                 self.tableView.deleteRows(at: [deleteIndexPath], with: .fade)
             }
             
             if let insertIndexPath = newIndexPath {
                 self.tableView.insertRows(at: [insertIndexPath], with: .fade)
             }
       
         default:
             print("me")
         }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                     sectionIndexTitleForSectionName sectionName: String) -> String? {
         return sectionName
     }
     
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                     didChange sectionInfo: NSFetchedResultsSectionInfo,
                     atSectionIndex sectionIndex: Int,
                     for type: NSFetchedResultsChangeType) {
         let sectionIndexSet = NSIndexSet(index: sectionIndex) as IndexSet
         
         switch type {
         case .insert:
             self.tableView.insertSections(sectionIndexSet, with: .fade)
         case .delete:
             self.tableView.deleteSections(sectionIndexSet, with: .fade)
         default:
             break
         }
     }
     }

}
