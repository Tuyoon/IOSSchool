//
//  Lesson7Classes.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 10.12.2020.
//

import UIKit

// MARK: - мутационные функции
// value типы могут иметь мутационные функции
struct L7Point {
	var x = 0.0
	var y = 0.0
	// мутационная функция, mutating указывает на то, что функция меняет значения объекта
	// без mutating получите ошибку компиляции с подсказкой, что нужно вставить это ключевое слово
	mutating func moveBy(x deltaX: Double, y deltaY: Double) {
		x = x + deltaX
		y += deltaY
	}
}

// MARK: - перечисления
enum L7LocationDirection: CaseIterable {
	case west
	case nord
	case east
	case south
	case southWest
	
	static var allValues: [L7LocationDirection] {
		return [.west, .nord, .east, .south, ]
	}
	
	var name: String {
		switch self {
		case .nord:
			return "nord"
		case .west:
			return "west"
		case .east:
			return "east"
		case .south:
			return "south"
		case .southWest:
			return "south west"
		}
	}
	
	var coorinates: CGPoint {
		switch self {
		case .nord:
			return CGPoint(x: 0, y: 1)
		case .west:
			return CGPoint(x: -1, y: 0)
		case .east:
			return CGPoint(x: 1, y: 0)
		case .south:
			return CGPoint(x: 0, y:-1)
		case .southWest:
			return CGPoint(x: -1, y:-1)
		}
	}
}

enum L7TrapezaType {
	case breakfast(coffee: Bool, eggsCount: Int)
	case lunch(soup: Bool)
	case dinner
	
	func printDescription() {
		switch self {
		case .breakfast(let coffee, let eggsCount):
			print("breakfast with coffee \(coffee), with eggs \(eggsCount)")
		case .lunch(let soup):
			print("lunch with soup \(soup)")
		case .dinner:
			print("dinner")
		}
	}
}

// MARK: - опции
struct L7Orientation: OptionSet {
	let rawValue: Int
	
	static let up = L7Orientation(rawValue: 1 << 0)
	static let right = L7Orientation(rawValue: 1 << 1)
	static let bottom = L7Orientation(rawValue: 1 << 2)
	static let left = L7Orientation(rawValue: 1 << 3)
	
	static let all: L7Orientation = [.up, .right, .bottom, .left]
}

// MARK: - Расширение протоколов, порядок вызова

protocol L7AnimalProtocol {
	func eat()
	func sleep()
}

extension L7AnimalProtocol {
	// методы реализованные в экстеншнах, вызываются в случае если объект реализующий протокол, не реализовал этот метод
	func eat() {
		print("animal eating");
	}
}

// структуры в свифте могут реализовывать протоколы в отличие от objective-c
struct L7AnimalMonkey: L7AnimalProtocol {
	func sleep() {
		print("monkey sleeping")
	}
	// будет использована реализация метода eat() из экстеншна
}

class L7AnimalDonkey: L7AnimalProtocol {
	func sleep() {
		print("Donkey sleeping")
	}
	
	func eat() {
		print("Donkey eating");
	}
}


class L7NotificationSender {
	// создали переменную-название уведомления
	static let L7NotificationSenderDidSendMessage: NSNotification.Name = NSNotification.Name("L7NotificationSenderDidSendMessage")
	
	func sendMessageWithDelay() {
		// через 5 сек отправляем уведомление
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			NotificationCenter.default.post(name: L7NotificationSender.L7NotificationSenderDidSendMessage, object: nil)
		}
	}
}
