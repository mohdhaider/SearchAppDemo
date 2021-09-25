//
//  CustomImageView.swift
//  SearchApp
//
//  Created by Haider on 25/09/21.
//

import UIKit

class CustomImageView: UIImageView {

    // MARK:- variables -
    
    enum ImageType: Int {
        case none = 0
        case roundImage = 1
        case cornerRadius4 = 2
    }
    
    // MARK: - Initializers -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    // MARK: - View Lifecycle -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyImageViewEffects()
    }
    
    // MARK:- Helpers -
    
    func applyImageViewEffects() -> Void {
        
        switch self.tag {
        case ImageType.roundImage.rawValue:
            self.backgroundColor = UIColor.darkGray
            self.layer.cornerRadius = self.frame.size.width/2.0
            self.clipsToBounds = true
            break
        case ImageType.cornerRadius4.rawValue:
            self.backgroundColor = UIColor.darkGray
            self.layer.cornerRadius = 4.0
            self.clipsToBounds = true
            break
            
        default:
            break
        }
    }
}
