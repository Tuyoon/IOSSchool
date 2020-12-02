//
//  Lesson6DetailsViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 02.12.2020.
//

import Foundation
import UIKit

class Lesson6DetailsViewController: UIViewController {
	@IBOutlet private var label: UILabel!
	private var name: String = "Default"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		label.text = name
		self.title = name
	}
	
	func configure(name: String) {
		self.name = name
	}
}
