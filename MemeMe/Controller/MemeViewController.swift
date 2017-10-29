//
//  MemeViewController.swift
//  MemeApp
//
//  Created by Erica on 10/9/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "Impact", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -6]
    
    @IBOutlet weak var memeNavigationBar: UINavigationBar!
    
    @IBOutlet weak var memeToolBar: UIToolbar!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareActionButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelToolBarButton: UIBarButtonItem!
    @IBOutlet weak var textFieldTop: UITextField!
    
    @IBOutlet weak var textFieldBottom: UITextField!
    
    let topText = "TOP"
    let bottomText = "BOTTOM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shareActionButton.isEnabled = false
        textFieldTop.delegate = self
        textFieldBottom.delegate = self
        
        configureTextFields(textField: textFieldTop, text: topText)
        configureTextFields(textField: textFieldBottom, text: bottomText)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    func configureTextFields(textField: UITextField, text: String!){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if textFieldBottom.isEditing {
            
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let image = info[ UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            imagePickerView.image = image
            shareActionButton.isEnabled = true
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalMeme: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func configureNavBarAndToolbar (isHidden: Bool) {
        memeToolBar.isHidden = isHidden
        memeNavigationBar.isHidden = isHidden
    }
    
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        configureNavBarAndToolbar(isHidden: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        configureNavBarAndToolbar(isHidden: false)
        
        return memedImage
    }
    
    @IBAction func shareMemeButton(_ sender: Any) {
        let newMemeImage = self.generateMemedImage()
        let memeActivityController = UIActivityViewController.init(activityItems: [newMemeImage], applicationActivities: nil)
        self.present(memeActivityController, animated: true, completion: nil)
        
        memeActivityController.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if completed {
                self.save(memedImage: newMemeImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func cancelButtonBar(_ sender: Any) {
        
        shareActionButton.isEnabled = false
        imagePickerView.image = nil
        configureTextFields(textField: textFieldTop, text: "TOP")
        configureTextFields(textField: textFieldBottom, text: "BOTTOM")
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func pick(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        pick(sourceType: .photoLibrary)
        
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        pick(sourceType: .camera)
    }
}


extension MemeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textFieldTop {
            textFieldTop.text = ""
        } else if textField == textFieldBottom {
            textFieldBottom.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        return true
    }
    
}






