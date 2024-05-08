//
//  ViewController.swift
//  iOSNoteApp
//
//  Created by Sonu Martin on 2024-05-04.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet var mainTableView: UITableView!
    
    var notesArray = [Note]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        if segue.identifier == "updateNote" {
            vc.note = notesArray[mainTableView.indexPathForSelectedRow!.row]
            vc.updateState = true
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNote()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNote()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = " \(notesArray[indexPath.row].title )"
        return cell
    }
}

extension ViewController: DataDelegate {
    
    func updateArray(newArray: String) {
        do {
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
            
        }catch {
            
            print("Failed To fetch Data")
        }
        
        self.mainTableView.reloadData()
    }
}
