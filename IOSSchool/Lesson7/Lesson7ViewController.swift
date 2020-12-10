//
//  Lesson7ViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 10.12.2020.
//

import UIKit

class Lesson7ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionTypes()
		notifications()
		mutatingFunctions()
		enums()
		protocolExtensions()
    }
	
	// MARK: - Collection Types
	private func collectionTypes() {
		print("\nCOLLECTION TYPES:")
		let array1: [String] = ["A", "B", "C", "D", "E"]
		let array2: [String] = ["C", "A", "F", "G", "H"]
		var array: [String] = []
		
		// сет хранит уникальные объекты, не повторяющиеся
		var set: Set<String> = Set<String>()
		
		for item in array1 {
			set.insert(item)
			array.append(item)
		}
		for item in array2 {
			set.insert(item)
			array.append(item)
		}
		
		print("array \(array)")
		print("set \(set)")
	}
	
// MARK: - Notifications
	
	// деструктор
	deinit {
		// удаляем себя как наблюдателя из центра уведомлений
		NotificationCenter.default.removeObserver(self)
	}
	
	private func notifications() {
		print("\nNOTIFICATIONS:")
		// applicationDidBecomeActiveNotification(_:) - сигнатура метода, аналогично в objective-C applicationDidBecomeActiveNotification:
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActiveNotification(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(notificationSenderDidSendMessage(_:)), name: L7NotificationSender.L7NotificationSenderDidSendMessage, object: nil)
		let notificationSender = L7NotificationSender()
		notificationSender.sendMessageWithDelay()
	}
    
	@objc private func applicationDidBecomeActiveNotification(_ notification: Notification) {
		print("applicationDidBecomeActiveNotification")
	}
	
	@objc private func notificationSenderDidSendMessage(_ notification: Notification) {
		print("notificationSenderDidSendMessage")
	}
	
// MARK: - Swift ENUMS
	private func mutatingFunctions() {
		print("\nMUTATING FUNCTION:")
		var point = L7Point(x: 0, y: 0)
		print("mutatingFunctions before: \(point.x) \(point.y)")
		point.moveBy(x: 5, y: 8)
		print("mutatingFunctions before: \(point.x) \(point.y)")
	}
	
	private func enums() {
		print("\nENUMS:")
		let direction: L7LocationDirection = .nord
		
		print("name \(direction.name)")
		print("coordinates \(direction.coorinates)")
		
		for direction in L7LocationDirection.allCases  {
			print("name \(direction.name) coordinates \(direction.coorinates)")
		}
		
		
		print("\nENUMS with Parameters:")
		var trapeza: L7TrapezaType = .breakfast(coffee: true, eggsCount: 2)
		trapeza.printDescription()
		trapeza = .lunch(soup: false)
		trapeza.printDescription()
		trapeza = .dinner
		trapeza.printDescription()
	}
	
// MARK: - Swift Protocol Extensions
	
	private func protocolExtensions() {
		print("\nProtocolExtensions:")
		let animal: L7AnimalProtocol = L7AnimalMonkey()
		animal.eat()
		animal.sleep()
		
		let animal2: L7AnimalProtocol = L7AnimalDonkey()
		animal2.eat()
		animal2.sleep()
	}
}
