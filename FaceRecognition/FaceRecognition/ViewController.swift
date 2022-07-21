//
//  ViewController.swift
//  FaceRecognition
//
//  Created by macbook on 18.06.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var labelTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SigninClicked(_ sender: Any) {
        
        let context = LAContext()
        
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")

            // Fall back to a asking for username and password.
            // ...
            return
        }
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
        
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "reason") { (success, error) in
                if success == true {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.labelTxt.text = "error"
                    }
                }
            }
        }
    }
}
