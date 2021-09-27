//
//  StackViewCel.swift
//  Metronome
//
//  Created by User on 26.09.2021.
//

import UIKit

class StackViewCel: NibLoadableView {
    
    @IBOutlet weak var image: UIImageView!
    
    
    
    func configure() {
        image.backgroundColor = Constants.MainBackgroundColor
        image.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
    }
    static func make(selected: Bool) -> UIView {
        let views = StackViewCel()
        views.backgroundColor = Constants.MainBackgroundColor
        views.configure()
        if selected {
            views.image.image = UIImage(named: "selectedCell")
        } else {
            views.image.image = UIImage(named: "currentCell")
        }
        return views
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
