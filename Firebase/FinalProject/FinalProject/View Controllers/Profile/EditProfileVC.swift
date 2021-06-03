import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class EditProfileVC: UIViewController {

    
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var facultyField: UITextField!
    @IBOutlet weak var aboutField: UITextField!
    
    
    // MARK: - Variables
    var currentUser = Auth.auth().currentUser
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("avatars")
        
    }
    
    // MARK: - Actions
    
    @IBAction func cancel_action(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @IBAction func done_action(_ sender: UIBarButtonItem) {
        if nameField.text != "" && surnameField.text != "" && lastnameField.text != "" && facultyField.text != ""{
            self.ref.child("users").child(currentUser!.uid).child("name").setValue(nameField.text!)
            self.ref.child("users").child(currentUser!.uid).child("surname").setValue(surnameField.text!)
            self.ref.child("users").child(currentUser!.uid).child("lastname").setValue(lastnameField.text!)
            self.ref.child("users").child(currentUser!.uid).child("aboutProfile").setValue(aboutField.text ?? "")
            self.ref.child("users").child(currentUser!.uid).child("facultyAndSpeciality").setValue(facultyField.text!)
        }
        dismiss(animated: true)
    }
    @IBAction func editImage_action(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
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


extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        editImage.image = image
    }
}
