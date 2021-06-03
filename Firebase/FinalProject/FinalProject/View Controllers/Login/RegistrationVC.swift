

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationVC: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registrationButton_Outlet: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    // MARK: - Variables
    var ref: DatabaseReference = Database.database().reference()
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationButton_Outlet.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func registrationButton_action(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        let name = nameField.text
        let surname = surnameField.text
        let lastname = lastnameField.text
        
        if email != "" && password != "" && name != "" && surname != "" && lastname != ""{
            if email!.contains("@kbtu.kz") {
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!) { [weak self](result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil{
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "dd.MM.yyyy"
//                        let date = dateFormatter.string(from: (self?.datePicker.date)!)
                        let userData = [
                            "email": email!,
                            "surname": surname!,
                            "name": name!,
                            "lastname": lastname!,
                            "password": password!
                        ]
                        self!.ref.child("users").child(result!.user.uid).setValue(userData)
                        self?.showMessage(title: "Success", message: "Please verify your email")
                }else{
                    self?.showMessage(title: "Error", message: "Wrong email or password!")
                }
            }
            }else{
                showMessage(title: "Error", message: "Please enter KBTU e-mail.")
            }}else{
                showMessage(title: "Error", message: "Fill all the fields!")
        }
    }
    
    // MARK: - Functions
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
