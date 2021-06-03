

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    // MARK: - Variables
    var students: [UserModel] = []
    var currentUser: User?
    
    // MARK: - Outlets
    @IBOutlet weak var kbtu_label: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var login_outlet: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewOutlet()
        loginLoadAnimation()
        currentUser = Auth.auth().currentUser
        // Do any additional setup after loading the view.
    }
    
    // MARK: - View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        if currentUser != nil && currentUser!.isEmailVerified {
            goToTabBar()
        }
    }
    
    // MARK: - Actions
    @IBAction func login_action(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        indicator.startAnimating()
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email!, password: password!) { [weak self](result, error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    if Auth.auth().currentUser!.isEmailVerified{
                        //Segue to Main VC
                        self?.goToTabBar()
                        self?.emailField.text = ""
                        self?.passwordField.text = ""
                    }else{
                        self?.showMessage(title: "Warning", message: "Please verify your email!")
                    }
                }else{
                    self?.showMessage(title: "Warning", message: "Some problems with authentification.")
                }
            }
        }
    }
    
    
    // MARK: - Functions
    
    func loginViewOutlet(){
        login_outlet.layer.cornerRadius = 15
    }
    
    func loginLoadAnimation(){
        login_outlet.alpha = 0
        
        let screnSize = UIScreen.main.bounds
        let screenWidth = screnSize.width
        let screenHeight = screnSize.height
        
        
        
        self.emailField.center = CGPoint(x: -1000, y: screenHeight/2 - 50)
        self.passwordField.center = CGPoint(x: 1000, y: screenHeight/2)
        
        
        UIView.animate(withDuration: 1){
            self.login_outlet.alpha = 1
            self.login_outlet.layer.cornerRadius = 10.0
            self.login_outlet.layer.borderWidth = 2
            self.login_outlet.layer.borderColor = CGColor.init(red: 255 , green: 255, blue: 255, alpha: 1)
        }
        
        UIView.animate(withDuration: 1){
             self.emailField.center = CGPoint(x: screenWidth/2, y: screenHeight/2 - 50)
             self.passwordField.center = CGPoint(x: screenWidth/2, y: screenHeight/2 + 15)
        }
    }
    
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToTabBar(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let TabBarPage = storyboard.instantiateViewController(identifier: "TabBarVC") as? MainTabBarVC{
            TabBarPage.modalPresentationStyle = .fullScreen
            present(TabBarPage, animated: true, completion: nil)
        }
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
