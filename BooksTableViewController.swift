//
//  BooksTableViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 19/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class BooksTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellBookTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let booktag = fetchedResultsController?.object(at: indexPath) as! BookTag
        let cell = tableView.dequeueReusableCell(withIdentifier: CellBookTableViewCell.cellId) as! CellBookTableViewCell
        
        cell.startObserving(bookTag: booktag)
        return cell
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BooksTableViewController{
    
    func registerNib(){
        let nib = UINib(nibName: "CellBookTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: CellBookTableViewCell.cellId)
        
    }
    
}

