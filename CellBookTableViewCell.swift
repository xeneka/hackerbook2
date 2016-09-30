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
    
    fileprivate let observableKey = ["book.Images.image","book.favorite","book.download"]
    
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
    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    
    override func prepareForReuse() {
        stopObserving()
    }
    
}


extension CellBookTableViewCell{
    
    func startObserving(bookTag: BookTag){
        
           self._booktag = bookTag
            syncViewWithModel()
        
        for each in observableKey {
            
        
            bookTag.addObserver(self, forKeyPath: each, options: [], context: nil)
        }
        
        
       
    }
    
    
    func stopObserving(){
        
        for each in observableKey {
            _booktag?.removeObserver(self, forKeyPath: each)
        }
        
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        syncViewWithModel()
    }
    
    func syncViewWithModel(){
        
        if let imageB = self._booktag?.book?.images?.image {
            
            imageBook.image = UIImage(data: imageB as Data)
            
        }
        
        if let favorite = _booktag?.book?.favorite {
            
            favoriteImage.isHidden = !favorite
        }
        
        
            bookTitle.text = self._booktag?.book?.title
        
    
        
    }
    
    
}
