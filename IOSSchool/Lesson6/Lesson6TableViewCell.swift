//
//  Lesson6TableViewCell.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 02.12.2020.
//

import Foundation
import UIKit

class Lesson6TableViewCell: UITableViewCell {
	@IBOutlet private var customImageView: UIImageView!
	@IBOutlet private var titleLabel: UILabel!
	
	override func awakeFromNib() {
		titleLabel.text = "bla bla bla"
		super.awakeFromNib()
	}
	
	func configure(image: UIImage, title: String) {
		customImageView.image = image
		titleLabel.text = title
	}
}
