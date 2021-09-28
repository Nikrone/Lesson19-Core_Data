//
//  MainTableViewCell.swift
//  lesson19
//
//  Created by Vladislav on 22.09.21.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func update(with text: String) {
        titleLabel.text = text
    }
}
