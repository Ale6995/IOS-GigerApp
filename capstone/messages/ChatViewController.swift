//
//  ChatViewController.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-12-07.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    var messagesList = [["user": "prueba1@yopmail.com", "message": "Hi Alejandro I would like more info about the gig"],["user": "prueba2@yopmail.com", "message": "Hi of course, it is about moving something"]]
    
    let currentUser=Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "messagesCell")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func textInput(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ChatViewController:UITableViewDataSource,UITableViewDelegate{
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messagesList.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell", for: indexPath)
         cell.textLabel?.text=messagesList[indexPath.row]["message"]
         if(currentUser?.email==messagesList[indexPath.row]["user"]){
             cell.backgroundColor=UIColor.init(named: "CardColor")!
             cell.textLabel?.textAlignment=NSTextAlignment.right
         }else{
             cell.backgroundColor=UIColor.init(named: "CardColorEnd")!
         }
        // Configure the cell...

        return cell
    }
    
    
}
