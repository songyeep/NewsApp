//
//  LoginVC.swift
//  NewsApp
//
//  Created by Songyee Park on 5/3/17.
//  Copyright © 2017 Songyee Park. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: UIButton) {
        if textFieldsAreFilled() {
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: pwTextField.text!, completion: { (user, error) in
                if error == nil {
                    print("FIREBASE EMAIL LOGIN SUCCESS")
                    self.completeAuthentication()
                } else {
                    let alert = AlertHelper.showError(error!.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if textFieldsAreFilled() {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: pwTextField.text!, completion: { (user, error) in
                if error == nil {
                    print("FIREBASE EMAIL SIGNUP SUCCESS")
                    self.completeAuthentication()
                } else {
                    let alert = AlertHelper.showError(error!.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    func textFieldsAreFilled() -> Bool {
        if emailTextField.text == "" || pwTextField.text == "" {
            let alert = AlertHelper.showError("Please fill in email and password.")
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func completeAuthentication() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(emailTextField.text).realm")
        Realm.Configuration.defaultConfiguration = config
        goToMainVC()
    }

    func goToMainVC() {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainSB.instantiateInitialViewController()
        self.present(mainVC!, animated: true, completion: nil)
    }
    
}
