//
//  L8ViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 14.12.2020.
//

import UIKit

class Lesson8ViewController: UIViewController {

	@IBOutlet private var galleryButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		localize()
		protocols()
		enums()
		generics()
	}
	
	private func localize() {
		// Файл локализации назывался Localization.strings, переименовал в стандартное Localizable.strings и все заработало
		// Комментарий нужен для разработки, чтобы понимать какой перевод используется. Можно оставить пустым
		// Указываем ключ строки с переводом из файла Localizable.strings
		let title = NSLocalizedString("L8.GalleryButton.Title", comment: "название кнопки галереи")
		galleryButton.setTitle(title, for: .normal)
	}
	
	private func protocols() {
		let point1: L8Point = L8Point(x: 1, y: 1)
		let point2: L8Point = L8Point(x: 2, y: 2)
		
		// Equatable - можем сравнивать объекты
		if point1 == point2 {
			
		}
		// Comparable - можем сравнивать кто больше, меньше
		if point1 >= point2 {
			
		}
		
		let hashablePoints: [L8HashablePoint] = []
		// Поиск объекта, указав блок для поиска
		// в этом примере ищем точку, где x == 1
		if hashablePoints.contains(where: { (point) -> Bool in
			point.x == 1
		}) {
			// условие выполнится, если в hashablePoints есть точка с x == 1
		}
		
		let hashablePoint = L8HashablePoint(x: 1, y: 1)
		// Hashable - можем проверять наличие объекта в коллекциях(массивы, сеты, словари)
		if hashablePoints.contains(hashablePoint) {
			
		}
		
		// Объекты структуры выводятся в стоки со всеми параметрами
		print("CustomStringConvertible struct \(hashablePoint)")
		
		// Объекты классы выводятся без параметров. Для них вручную выводим параметры используя протокол CustomStringConvertible
		let stringConvertiblePoint = L8StringConvertiblePont()
		print("CustomStringConvertible class \(stringConvertiblePoint)")
	}
	
	private func enums() {
		let intPoint: L8IntPoints = .point1
		if intPoint.rawValue == 1 {
			print("ENUMS it's int .poin1")
		}
		
		let stringPoint: L8StringPoints = .point1
		if (stringPoint.rawValue == "p1") {
			print("ENUMS it's string .poin1")
		}
		
		// L8TrapezaType реализует протокол RawRepresentable
		// создаем опцию передав Raw значеие "breakfast"
		if let trapeza = L8TrapezaType(rawValue: "breakfast") {
			print("RawRepresentable with L8TrapezaType.breakfast")
		}
		if L8TrapezaType(rawValue: "incorrect raw value") == nil {
			print("RawRepresentable with incorrect raw value ")
		}
		
	}
	
	private func generics() {
//		Структура L8GenericPoint работает с указанным типом данных x и y
		// точка с x и y типа Int
		let intPoint: L8GenericPoint<Int> = L8GenericPoint(x: 1, y: 1)
		// точка с x и y типа Double
		let doublePoint: L8GenericPoint<Double> = L8GenericPoint(x: 0.1, y: 0.2)
		// используем generic функцию, которая возвращает значение того же типа, что и переменные (Double)
		print("GENERICS max is \(doublePoint.maxXorY())")
		
	}
}
