//
//  CustomView.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 20.11.2020.
//

import UIKit

class CustomView: UIView {

	private let label: UILabel
	private let label2: UILabel
	
	let publicLabel: UILabel
	
	override init(frame: CGRect) {
		self.label = UILabel(frame: frame)
		self.label2 = UILabel(frame: frame)
		self.publicLabel = UILabel(frame: frame)
		
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
