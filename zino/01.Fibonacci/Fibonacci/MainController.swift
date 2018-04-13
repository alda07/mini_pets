//
//  ViewController.swift
//  Fibonacci
//
//  Created by Hanh Vo on 10/13/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit
import BigInt

class MainController: UIViewController {
    
    // MARK: UI
    @IBOutlet weak var nTextField: UITextField!
    @IBOutlet weak var fibonacciTable: UITableView!
    
    // MARK: Properties
    var fibonacciList = [BigInt]()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure when beginning
        configureForBeginning()
    }
    
    // MARK: Actions
    @IBAction func calculateTapped(_ sender: AnyObject) {
        
        // Handle for calculating
        caculateHandle()
    }
    
    // MARK: PrivateMethods
    private func configureForBeginning()  {
        
        // For nTextField
        nTextField.keyboardType = UIKeyboardType.numberPad
        
        // For fibonacciTable
        fibonacciTable.dataSource = self
        fibonacciTable.delegate = self
    }
    
    private func caculateHandle()
    {
        // Hide keyboard
        nTextField.resignFirstResponder()
        
        // Clear data if any
        if (fibonacciList.count > 0)
        {
            fibonacciList.removeAll()
            fibonacciTable.reloadData()
        }
        
        // Validate input
        if (nTextField.text?.isEmpty)! || (Int(nTextField.text!)! <= 0){
            
            let alertController = UIAlertController(title: "Error", message: "(N) is empty or an invalid number (N must be greater than 0)", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {}
            
        }
        else
        {
            // Find fibonacci numbers
            createFibonaciList()
        }

    }
    
    private func memoize<T: Hashable, U>(_ body: @escaping ((T)->U, T) -> U) -> (T)->U {
        var memo = [T: U]()
        var result: ((T)->U)!
        result = { x in
            if let q = memo[x] { return q }
            let r = body(result, x)
            memo[x] = r
            return r
        }
        return result
    }
    
    private func createFibonaciList() {
        
        let N = Int(nTextField.text!)!
        let fib = memoize { (fibonacci:(Int)->BigInt,n:Int) in n < 2 ? BigInt(n) : fibonacci(n-1) + fibonacci(n-2) }
        
        for n in 1...N{
            fibonacciList.append(fib(n))
        }
        
        fibonacciTable.reloadData()
    }

}

// MARK: Life Cycle
extension MainController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fibonacciList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        // Display data for cell
        let value = String(fibonacciList[(indexPath as NSIndexPath).row])
        let countString = "n = " + String((indexPath as NSIndexPath).row + 1)
        cell.faNumber.text = value
        cell.N.text = countString
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension MainController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}





