//
//  Lesson6ViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 02.12.2020.
//

import UIKit

class Lesson6ViewController: UIViewController {
	
	@IBOutlet private var tableView: UITableView!
	private var imageNames: [[String]] = [
		["trash", "trash.fill", "trash.circle"],
		["doc"],
		["tray", "tray.fill", "tray.circle", "tray.2", "tray.2.fill", "tray.full", "doc.fill", "doc.circle"]
	]
	private var titles: [[String]] = [
		["General", "Accesisibility", "Privacy"],
		["Passwords"],
		["Safari", "News", "Maps", "Shortcuts", "Health", "Siri & Search", "Photos", "Game Center"]
	]
    override func viewDidLoad() {
        super.viewDidLoad()
		configureTableView()
        // Do any additional setup after loading the view.
    }
}

extension Lesson6ViewController {
	private func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
	}
}

extension Lesson6ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 3
		case 1:
			return 1
		case 2:
			return 8
		default:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "DisclosureCell") as! Lesson6TableViewCell
		let imageName = imageNames[indexPath.section][indexPath.row]
		let title = titles[indexPath.section][indexPath.row]
		cell.configure(image: UIImage(systemName: imageName)!, title: title)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Section \(section)"
	}
}

extension Lesson6ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard let controller = storyboard?.instantiateViewController(withIdentifier: "Lesson6DetailsViewController") as? Lesson6DetailsViewController else {
			return
		}
		controller.configure(name: titles[indexPath.section][indexPath.row])
		navigationController?.pushViewController(controller, animated: true)
	}
}
