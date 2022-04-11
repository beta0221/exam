//
//  GridVC.swift
//  exam
//
//  Created by 林奕儒 on 2022/4/7.
//

import UIKit

class Grid:UIView{
    
    var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 6
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
    }
    
    func showRandom(){
        button.setTitle("Random", for: .normal)
    }
    
    func clear(){
        button.setTitle("", for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class GridVC: UIViewController {

    @IBOutlet weak var gridView: UIView!
    var timer:Timer?
    
    
    var rows:Int!
    var columns:Int!
    
    var gridMap = Dictionary<String,Grid>()
    var columnMap = Dictionary<Int,UIView>()
    var currentKey:String?
    var currentColumn:Int?
    
    
    let buttonHeight:CGFloat = 80.0
    let spacing:CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackedGrid(rows: rows ?? 0, columns: columns ?? 0, rootView: self.gridView)
        
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showRandomGrid), userInfo: nil, repeats: true)
    }
    
    
    private func stackedGrid(rows: Int, columns: Int, rootView: UIView){
        
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        //horizontalStack.spacing = spacing
        
        for col in 0 ..< columns {
            
            let verticalStack = UIStackView()
            verticalStack.axis = .vertical
            verticalStack.distribution = .fillEqually
            //verticalStack.spacing = spacing
            
        
            for row in 0 ..< rows {
                
                let grid = Grid()
                let key = "\(row)-\(col)"
                self.gridMap[key] = grid
                verticalStack.addArrangedSubview(grid)
                
            }
            
            
            let columnView = UIView()
            columnView.layer.cornerRadius = 6
            columnMap[col] = columnView
            columnView.addSubview(verticalStack)
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            verticalStack.topAnchor.constraint(equalTo: columnView.topAnchor, constant: spacing).isActive = true
            verticalStack.leftAnchor.constraint(equalTo: columnView.leftAnchor, constant: spacing).isActive = true
            verticalStack.rightAnchor.constraint(equalTo: columnView.rightAnchor, constant: -spacing).isActive = true
            verticalStack.bottomAnchor.constraint(equalTo: columnView.bottomAnchor, constant: -buttonHeight).isActive = true
            
            
            
            let grid = Grid()
            grid.button.setTitle("確定", for: .normal)
            grid.button.addTarget(self, action: #selector(onButton), for: .touchUpInside)
            grid.button.tag = col
            columnView.addSubview(grid)
            grid.translatesAutoresizingMaskIntoConstraints = false
            grid.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
            grid.leftAnchor.constraint(equalTo: columnView.leftAnchor, constant: spacing).isActive = true
            grid.rightAnchor.constraint(equalTo: columnView.rightAnchor, constant: -spacing).isActive = true
            grid.bottomAnchor.constraint(equalTo: columnView.bottomAnchor, constant: -spacing).isActive = true
            
            
            horizontalStack.addArrangedSubview(columnView)
            
        }
        
        
        rootView.addSubview(horizontalStack)
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.topAnchor.constraint(equalTo: rootView.topAnchor, constant: spacing).isActive = true
        horizontalStack.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: spacing).isActive = true
        horizontalStack.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -spacing).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -spacing).isActive = true
        showRandomGrid()
    }
    
    @objc private func showRandomGrid(){
        print("show Random grid")
        
        if(currentColumn != nil){
            if columnMap[currentColumn!] != nil{
                let columnView = columnMap[currentColumn!]
                columnView?.backgroundColor = .white
            }
        }
        
        if currentKey != nil{
            if gridMap[currentKey!] != nil{
                let grid = gridMap[currentKey!]
                grid?.clear()
            }
        }
        
        let row = Int.random(in: 0..<rows!)
        let col = Int.random(in: 0..<columns!)
        let key = "\(row)-\(col)"
        
        if gridMap[key] != nil{
            let grid = gridMap[key]
            grid?.showRandom()
        }
        
        if columnMap[col] != nil{
            let columnView = columnMap[col]
            columnView?.backgroundColor = .blue
        }
        
        print(key)
        currentKey = key
        currentColumn = col
        
    }
    
    
    @objc private func onButton(_ sender:UIButton){
        
        print("onButton")
        if(sender.tag != currentColumn){
            return
        }
        
        if(currentColumn != nil){
            if columnMap[currentColumn!] != nil{
                let columnView = columnMap[currentColumn!]
                columnView?.backgroundColor = .white
            }
        }
        
        if currentKey != nil{
            if gridMap[currentKey!] != nil{
                let grid = gridMap[currentKey!]
                grid?.clear()
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    

}
