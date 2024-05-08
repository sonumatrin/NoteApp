//
//  SafariView.swift
//  iOSNoteApp
//
//  Created by Sonu Martin on 2024-05-05.
//
//
//import Foundation
//import SafariServices
//import SwiftUI
//
//struct SafariView: UIViewControllerRepresentable {
//    
//    let url: URL
//    
//    func makeUIViewController(context: UIViewRepresentableContext<SafariView>) ->
//    SFSafariViewController {
//        SFSafariViewController(url: url)
//    }
//    
//    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewRepresentableContext<SafariView>) {
//    }
//    
//}

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No need to implement this method if you don't need to update the view controller
    }
}

