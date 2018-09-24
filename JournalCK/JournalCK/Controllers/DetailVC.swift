//
//  DetailVC.swift
//  JournalCK
//
//  Created by Markus Varner on 9/24/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    
    
    //Landing Pad
    var entry: Entry? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    
    @IBAction func saveBP(_ sender: UIBarButtonItem) {
        
        guard let titleText = titleTF.text,
            let bodyText = bodyTextView.text else {return}
            
        EntryController.shared.createNewWith(title: titleText, body: bodyText)
        
        navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        
        if let entry = entry {
            DispatchQueue.main.async {
                self.titleTF.text = entry.title
                self.bodyTextView.text = entry.body
            }
            
        }
    }
    
}
