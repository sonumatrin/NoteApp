//
//  AddNoteViewController.swift
//  iOSNoteApp
//
//  Created by Sonu Martin on 2024-05-05.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    var note: Note?
    var updateState = false
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var saveClick: UIBarButtonItem!
    
    @IBAction func SaveAction(_ sender: Any) {
        if updateState == true {
            APIFunctions.functions.updateNote(date: "placeholder", note: bodyTextView.text!, title: titleTextField.text!, id: note!._id)
        }else  {
            APIFunctions.functions.AddNote(date: "placeholder", title: titleTextField.text!, note: bodyTextView.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if updateState == true {
            APIFunctions.functions.deleteNote(id: note!._id)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if updateState == true {
            titleTextField.text = note?.title
            bodyTextView.text = note?.note
        }
        // Do any additional setup after loading the view.
    }
    

}
