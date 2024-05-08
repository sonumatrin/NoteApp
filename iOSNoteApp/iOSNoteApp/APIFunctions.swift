//
//  APIFunctions.swift
//  iOSNoteApp
//
//  Created by Sonu Martin on 2024-05-04.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var title: String
    var note: String
    var date: String
    var _id: String
}

class APIFunctions {
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchNote() {
        
        AF.request("http://192.168.68.109:8081/fetch").response { response in
            
            print(response.data)
            let data = String(data: response.data!, encoding: .utf8)
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func AddNote(date: String, title: String, note: String) {
        
        AF.request("http://192.168.68.109:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON { response in
            
            print("add not\(response)")
            
        }
    }
    
    func updateNote(date: String, note: String, title: String, id: String) {
        AF.request("http://192.168.68.109:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date, "id": id]).responseJSON { response in
            
            print(response)
        }
        
    }
    
    func deleteNote(id: String) {
        
        AF.request("http://192.168.68.109:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON { response in
            
            //deleted
        }
    }
}


