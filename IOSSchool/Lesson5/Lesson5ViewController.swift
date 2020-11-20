//
//  Lesson5ViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 20.11.2020.
//

import UIKit

class Lesson5ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet private var imageView: UIImageView!
	@IBOutlet private var optionalImageView: UIImageView?
	@IBOutlet private weak var cancelBarButton: UIBarButtonItem!
	@IBOutlet private weak var addBarButtonItem: UIBarButtonItem!
	private let imageLet = UIImage()
	private var imageVar: UIImage!
	private var customView: CustomView!
		
	override func viewDidLoad() {
        super.viewDidLoad()
		
		imageVar = UIImage()
		imageView?.image = UIImage()
		
		createCustomView()
	}
	
	private func createCustomView() {
		customView = CustomView(frame: CGRect(x: 50, y: 50, width: 200, height: 100))
		customView.backgroundColor = UIColor.green
		view.addSubview(customView)
	}
	
	// MARK: - Unwrapping
	
	private func ternarOperation() {
//		(a ? b : c)
		let size: CGSize = optionalImageView != nil ? CGSize(width: 100, height: 100) : CGSize.zero
		print("size = \(size.width) - \(size.height)")
	}
	
	private func ifUnwrapping() {
		var size: CGSize = optionalImageView?.image?.size ?? CGSize.zero
		
		if let imageView = optionalImageView,
		   let image = imageView.image {
			size = image.size
		}
		if let image = optionalImageView?.image {
			size = image.size
		}
		print("size = \(size.width) - \(size.height)")
    }
	
	private func guardUnwrapping() {
		let condition = false
		
		guard condition == true else {
			return
		}
		print("guard unwrapped")
	}
	
	private func guardLetUnwrapping() {
		guard let imageView = optionalImageView, let image = imageView.image else {
			return
		}
		print("size = \(image.size.width) - \(image.size.height)")
	}
    
	// MARK: - Actions
	
	@IBAction private func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
		
	}

	@IBAction private func addBarButtonPressed(_ sender: Any) {
		print("addBarButtonPressed")
	}
	
	@IBAction private func switchValueChanged(_ sender: UISwitch) {
		print("switchValueChanged")
		if sender.isOn {
			customView.backgroundColor = UIColor.red
		} else {
			customView.backgroundColor = UIColor.blue
		}
	}
	
	@IBAction private func buttonTouchUpOusidePressed(_ sender: Any) {
		print("buttonTouchUpOusidePressed")
	}
	
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	// MARK: - UITextFieldDelegate
	func textFieldDidBeginEditing(_ textField: UITextField) {
		print("textFieldDidBeginEditing")
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		print("textFieldDidEndEditing")
	}
}


