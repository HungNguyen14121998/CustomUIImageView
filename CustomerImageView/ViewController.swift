//
//  ViewController.swift
//  CustomerImageView
//
//  Created by Nguyen Huu Hung on 6/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    let backgroundColors: [UIColor] = [#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1), #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1),#colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1),#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1),#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1),#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1),#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1),#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)]
    let darkerBackgroundColors: [UIColor] = [#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1), #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1), #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1), #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1),#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1),#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1),#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1),#colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1),#colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1),#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)]
    var indexColor = Int.random(in: 0...11)
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setAvatar(name: "", image: UIImage(named: "myAvatar"), color: darkerBackgroundColors[indexColor])
        
    }
    
    func setAvatar(name: String, image: UIImage?, color: UIColor) {
        indexColor = Int.random(in: 0...11)
        let profileImage = SwiftyAvatar(name: name, image: image, color: darkerBackgroundColors[indexColor])
        profileImage.frame = CGRect(x: (self.view.frame.width / 2) - 100, y: (self.view.frame.height / 2) - 100, width: 200, height: 200)
        profileImage.background = backgroundColors[indexColor]
        
        view.addSubview(profileImage)
    }

    @IBAction func uploadImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
}

// MARK: TextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let fullName = textField.text ?? ""
        
        //Take all capital letters of fullName: A -> Z Ă Â Ê Ư Ô Ơ Đ based on the value ASCII charset:
        let capitalLetters = (fullName.unicodeScalars.filter {
            let word = $0.value
            let result = (word > 64 && word < 91) || word == 202 || word == 212 || word == 416 || word == 431 || word == 258 || word == 194 || word == 272
            return result
        })
        
        if let firstCapitalLetter = capitalLetters.first, let lastCapitalLetter = capitalLetters.last{
            let abbreviation: String
            if capitalLetters.count == 1 {
                abbreviation = String(firstCapitalLetter)
            } else {
                abbreviation = String(firstCapitalLetter) + String(lastCapitalLetter)
            }
            setAvatar(name: abbreviation, image: nil, color: darkerBackgroundColors[indexColor])
        }
        else {
            setAvatar(name: "", image: UIImage(named: "myAvartar"), color: darkerBackgroundColors[indexColor])
        }
        
        return true
    }
}

// MARK: UIImagePickerController Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            setAvatar(name: "", image: image, color: darkerBackgroundColors[indexColor])
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

