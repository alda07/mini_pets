//
//  ViewController.swift
//  2.
//
//  Created by Hanh Vo on 10/12/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    //MARK: - LifeCyle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureForBeginning()
    }
    // MARK: - Internal methods
    private func configureForBeginning(){
        
        // For Navigation
        self.title = "2.?"
        
        // Set default backgroundColor is red
        updateUI(color:.red)
    }
    
    //MARK: Public Methods
    func updateUI(color:UIColor)  {
        
        self.view.backgroundColor = color
    }
 
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var screenType: ScreenType = .None
        var color: UIColor = .white
               
        if (segue.identifier == "redSegue")
        {
            screenType = .Red
            color = .red
        }
        else if (segue.identifier == "greenSegue")
        {
             screenType = .Green
            color = .green
        }
        else
        {
            screenType = .Blue
            color = .blue
        }
        
        let detail:DetailController = segue.destination as! DetailController
        detail.delegate = self
        detail.screenInfo = (screenType,color )
        
    }
    
}

// MARK: DetailDelegate
extension MainController:DetailDelegate{
    
    func backToSupperView(screenInfo: (ScreenType,UIColor))
    {
        self.updateUI(color: screenInfo.1)
    }
}

