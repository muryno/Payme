//
//  ViewController.swift
//  Payme
//
//  Created by Muraino Yakubu on 3/17/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class LoginViewController: UIViewController , LoginView, ManageObjectContextDependentType{
    
    var managedObjectContext: NSManagedObjectContext!
    

    var presenter : LoginPresenter!

    
    @IBOutlet weak var edt_email: UITextField!
    
    @IBOutlet weak var edt_pass: UITextField!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
   
          presenter = LoginPresenter(self)

        
        
        let im = UIImage(named: "email")
        edt_email.setLeftView(image: im!)

        let i = UIImage(named: "lock")
        edt_pass.setLeftView(image: i!)
        
        
        
     // FirebaseApp.configure()
        
 
   }
    

       
    @IBAction func btn_click(_ sender: Any) {


          presenter.inValidateLogin(email : edt_email.text!, passwrd : edt_pass.text!)
      
    }

      
    
       func Loading() {
        if #available(iOS 13.0, *) {
            self.showSpinner(onView: self.view)
        } else {
            // Fallback on earlier versions
        }
       }
       
       func LoadingFail(msg: String) {
              self.removeSpinner()
              displayMessage(status : true, msg : msg)
       }
       
        func LoadingSuccessfull(msg: String) {
             
            userLoggedIn()
                displayMessage(status : true, msg : msg)
              self.removeSpinner()

       }
       
       
       
       func invalidateEmail(email: String) {
           displayMessage(status : false, msg : email)
           
       }
       
       func invalidatePassword(password: String) {
           print(password)
           displayMessage(status : false, msg : password)
       }
       

       

       func displayMessage(status : Bool, msg : String ){
              
              var state : String!
            if status == false {  state = "Error" }else { state = "Success"}
              let alertController = UIAlertController(title: state,
                                                                  message: msg,
                                                                  preferredStyle: .alert)
                      
                          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                          alertController.addAction(cancelAction)
                          self.present(alertController, animated: true, completion: nil)
          }
       


    
    
      func userLoggedIn(){
          
           let token = MemoryManager().getUser().authorization  ?? ""
          
          if token != "" {
            
          
               let tabBarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier") as! UITabBarController
              
                   tabBarViewController.viewControllers?.forEach {
                                   if let nc = $0 as? UINavigationController {
                                   let vc = nc.viewControllers[0]  as?    HomeControllerViewController
                                   vc?.managedObjectContext  =  self.managedObjectContext
                                     
                                         
                                   vc?.testmen = "Biolaa"
                                     }
                                }

                     view.window?.rootViewController = tabBarViewController
                   //  view.window?.makeKeyAndVisible()
          }
      
      }
    
   

     
        
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
         self.userLoggedIn()
            NotificationCenter.default.removeObserver(self)
        }
             
    }
    
}

