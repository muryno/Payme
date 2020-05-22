//
//  ViewController.swift
//  Payme
//
//  Created by Muraino Yakubu on 3/17/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    
    @IBOutlet weak var edt_email: UITextField!
    
    @IBOutlet weak var edt_pass: UITextField!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
   

        let im = UIImage(named: "email")
        edt_email.setLeftView(image: im!)

        let i = UIImage(named: "lock")
        edt_pass.setLeftView(image: i!)
        
        
        
    
        
       }
    
    override func viewDidLayoutSubviews() {
            if (UserDefaults.standard.isLoggedIn()){
                    SegueHome()
               }
            
    }
       

  
       
    @IBAction func btn_click(_ sender: Any) {

        let name: String = edt_email.text ?? ""

        let pass: String = edt_pass.text ?? ""
        
        handleLogin(name,pass)
        //
    }

    func handleLogin(_ email : String, _ password :String){
        
        if  email.isEmpty{
            self.showToast(message: "Email is require", seconds: 1.0)
            return
        }
     
        if  password.isEmpty {
                   self.showToast(message: "password is require", seconds: 1.0)
                   return
        }
        
        
        let queryItems = [
                    "email": email,
                    "password": password
                ]
        
        
         self.showSpinner(onView: self.view)
              let qualityOfServiceClass = DispatchQoS.QoSClass.background
                        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                        backgroundQueue.async(execute: {
        
                             // 3: Do your networking task or background work here.
        
                            let url = "user/login"
        
                                   let req:Request = Request()
                            
                            req.getResponse(url: url, parameters: queryItems as [String : Any], httpMethod: .post) {(result: Results<UserBase>) in
        
                                DispatchQueue.main.async(execute: { () -> Void in
        
                                    switch result{
                                        case .failure(let error):

                                            print("Error\(error)")
                                            self.showToast(message: "Error\(error)", seconds: 2.0)
                                         self.removeSpinner()
                                        case .success( let successfful):
                                            
                                            //move to home
                                            self.SegueHome()
                                            self.userSession()
                                     
                                            print("Created Succefully\(successfful)")
                                            self.showToast(message:"Login Succefully", seconds: 2.0)

        
                                             self.removeSpinner()
                                            UserDefaults.standard.setLoggedIn(value: true)
        
                                        }
        
        
                                })
          }
        })
    }
    
    
    func SegueHome() {
        let myTabBar   = self.storyboard?.instantiateViewController(withIdentifier: "MainTab") as! UITabBarController
               let appDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
               appDelegate.window?.rootViewController = myTabBar
                                             
    }
   
    func userSession() {
            UserDefaults.standard.set(true, forKey: "login")
            UserDefaults.standard.synchronize()
    }
        
    
    
}

