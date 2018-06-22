//
//  FileTableViewCell.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/21.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell {
    @IBOutlet weak var fileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
