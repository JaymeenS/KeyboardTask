//  SixthView.swift
//  TextFieldKeyboard
//
//  Created by MacbookAir on 29/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    var keyboardIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector:#selector(makeSpaceForKeyboard(notification:)) ,name:UIResponder.keyboardWillShowNotification, object: nil);
             
        NotificationCenter.default.addObserver(self, selector: #selector(makeSpaceForKeyboard(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil);
        
    }

    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
  
    
    @objc func makeSpaceForKeyboard(notification: NSNotification) {
        
        let info = notification.userInfo!
        let keyboardHeight:CGFloat = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
        let duration:Double = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        if notification.name == UIResponder.keyboardWillShowNotification && keyboardIsVisible == false{
            
            keyboardIsVisible = true
            
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.view.frame
                frame.size.height = frame.size.height - keyboardHeight
                self.view.frame = frame
            })
            
        } else if keyboardIsVisible == true && notification.name == UIResponder.keyboardWillShowNotification{
            
        }else {
            keyboardIsVisible = false
            
            UIView.animate(withDuration: duration, animations: { () -> Void in
                var frame = self.view.frame
                frame.size.height = frame.size.height + keyboardHeight
                self.view.frame = frame
            })
        }
    }
    @IBAction func hideKeyBoardAction(_ sender: Any) {
        print("Keayboard is hide..!!")
        
        textField.resignFirstResponder()
     
    }
}
extension ViewController:UITextFieldDelegate
{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
