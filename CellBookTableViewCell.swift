//
//  CellBookTableViewCell.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 21/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class CellBookTableViewCell: UITableViewCell {

    static let cellId = "CellBookTableViewCell"
    static let cellHeight:CGFloat = 66
    
    fileprivate let _nc = NotificationCenter.default
    
    fileprivate var _booktag:BookTag? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var imageBook: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
   
    
}


extension CellBookTableViewCell{
    
    func startObserving(bookTag: BookTag){
        
           self._booktag = bookTag
            syncViewWithModel()
           bookTag.addObserver(self, forKeyPath: "book.Images.image", options: [], context: nil)
       
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        syncViewWithModel()
    }
    
    func syncViewWithModel(){
        imageBook.image = UIImage(data: self._booktag?.book?.images?.image as! Data)
        bookTitle.text = self._booktag?.book?.title
    }
    
    
}
