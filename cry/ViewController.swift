//
//  ViewController.swift
//  cry
//
//  Created by Sideeq on 11/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    

    @IBAction func buttonPressed(_ sender: Any) {
        
        if let symbol = textField.text {
            
            getData(symbol : symbol)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //getData()
    }
    
    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
    
    func getData(symbol : String) {
        
        
        url = "\(url)&fsym=\(symbol)"
        //1. Initialize the URL
        guard let url = URL(string: url) else {return}
        
        //2. Initialize task and URL Session
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            //Check Optional
            
            guard let data = data, error == nil else {return}
            
            print("Data Recieved")
            
            do {
                
            let Result = try JSONDecoder().decode(APIResponse.self, from: data)
                
            print(Result.USD)
                
                //               |HOV (Grand Central Dispatch)|1|2|3|4|5|
                //
                //                sync | async | concurrency | sequential
                //
                //
                //                seq : A -> B -> C
                //                conc :
                //                A -----end time
                //                B ----------
                //                C -----
                //
                //                0
                
                DispatchQueue.main.async{
                    
                
                self.outputLabel.text = "\(Result.USD)"
                }
            }
            catch{
                
                print(error.localizedDescription)
                
            }
        

        }
        
        //Resume Task
        task.resume()
        
                //CLOSURE - create a function with function  with function
    }
    
    struct APIResponse : Codable {
        
        let USD : Float
    }
}


