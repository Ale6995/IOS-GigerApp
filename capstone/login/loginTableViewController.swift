//
//  loginTableViewController.swift
//  capstone
//
//  Created by Alejandro Morales on 2021-11-25.
//

import UIKit
import FirebaseAuth

class loginTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    @IBOutlet weak var usernameInput: UITextView!
    //
    @IBOutlet weak var passwordInput: UITextView!
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    @IBAction func loginButton(_ sender: Any) {
        
      guard
        let email = usernameInput.text,
        let password = passwordInput.text,
        !email.isEmpty,
        !password.isEmpty
      else { return }

      Auth.auth().signIn(withEmail: email, password: password) { user, error in
        if let error = error, user == nil {
          let alert = UIAlertController(
            title: "Sign In Failed",
            message: error.localizedDescription,
            preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "OK", style: .default))
          self.present(alert, animated: true, completion: nil)
        }
          else{
              self.dismiss(animated: true) {
                  
              }
          }
      }
    }
    //        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "loginViewCell", for: indexPath)
//        let gradient:CAGradientLayer = CAGradientLayer()
//        gradient.frame.size = cell.bounds.size
//        gradient.colors = [UIColor.init(named: "CardColor")!.cgColor,UIColor.init(named: "CardColorEnd")!.cgColor] //Or any colors
//            cell.layer.insertSublayer(gradient, at: 0)
//
//
//        return cell
//    }
//    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
