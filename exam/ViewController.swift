//
//  ViewController.swift
//  exam
//
//  Created by 林奕儒 on 2022/4/7.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var rowsTextfield: UITextField!
    @IBOutlet weak var columnsTextfield: UITextField!
    
    
    var rows:Int?
    var columns:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.donePressed))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    private func isValid() -> Bool{
        
        guard let _rows = rowsTextfield.text,let _columns = columnsTextfield.text else { return false }
        
        guard let rows = Int(_rows),let columns = Int(_columns) else { return false }
        
        if(rows < 1 || columns < 1){ return false}
        
        self.rows = rows
        self.columns = columns
        
        return true
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        if(!isValid()){ return }
        
        performSegue(withIdentifier: "submitSegue", sender: self)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gridVC = segue.destination as? GridVC else { return }
        
        gridVC.rows = self.rows ?? 0
        gridVC.columns = self.columns ?? 0
        
    }
    
}

