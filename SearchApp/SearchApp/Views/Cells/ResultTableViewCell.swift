//
//  ResultTableViewCell.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import UIKit

protocol ResultCellContentProtocol {
    
    var imageUrl: String? {get}
    var title: String? {get}
    var location: String? {get}
    var date:String? {get}
}

class ResultTableViewCell: UITableViewCell {

    // MARK:- IBOutlets -
    
    @IBOutlet weak var resultImageView: CustomImageView!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultDetails: UILabel!
    @IBOutlet weak var sectionSeparator: UILabel!
    
    // MARK:- Cell Life Cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK:- Class Helpers -
    
    private func initialSetup() {
        
        resultTitle.textColor = .black
        resultTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        resultDetails.textColor = .lightGray
        resultDetails.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        resultImageView.tag = CustomImageView.ImageType.cornerRadius4.rawValue
        resultImageView.applyImageViewEffects()
        
        sectionSeparator.backgroundColor = .lightGray
    }
    
    func populateInfo(_ info: ResultCellContentProtocol?) {
        
        guard let info = info else { return }
        
        resultImageView.setImage(forUrl: info.imageUrl, placeholderImage: UIImage.placeholderImage())
        
        var contents = [String]()
        if let val = info.location {
            contents.append(val)
        }
        if let val = info.date {
            contents.append(val)
        }
        
        resultTitle.text = info.title
        resultDetails.text = contents.joined(separator: "\n")
    }
}
