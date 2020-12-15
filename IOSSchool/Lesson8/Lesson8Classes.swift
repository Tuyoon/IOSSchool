//
//  L7Classes.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 14.12.2020.
//

import Foundation

// Comparable наследуется от Equatable, поэтому тут можно было просто написать ..
// struct L8Point: Comparable {
struct L8Point: Equatable, Comparable {
	var x: Int
	var y: Int
	
	// Equatable
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	
	// Comparable. Есть также операторы <=, >, >=. Обычно их можно не реализовывать т.к. их логику можно проверить используя имеющиеся операторы == и <
	static func < (lhs: L8Point, rhs: L8Point) -> Bool {
		return lhs.x < rhs.x
	}
}

struct L8HashablePoint: Hashable {
	var x: Int
	var y: Int

	// Hashable наследуется от Equatable, поэому реализуем Equatable тоже
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	
	// Формируем хеш значения, поместив наши значения в Hasher
	func hash(into hasher: inout Hasher) {
		hasher.combine(x)
		hasher.combine(y)
	}
}

class L8StringConvertiblePont: CustomStringConvertible {
	var x: Int = 0
	var y: Int = 0
	
	// Если наследоваться от NSObject, который имеет поле description, то достаточно его переопределить
//	override var description: String { }
	var description: String {
		return "x = \(x), y = \(y)"
	}
}

// Перечисление с Raw значением типа Int
// по умолчанию нумерация с 0. point1 = 0, point2 = 1, point3 = 2
// можно указать с чего будет начинаться нумерация, либо задать значения для каждой опции
enum L8IntPoints: Int {
	case point1 = 1
	case point2 // тут будет point1.rawValue + 1 т.е. 2
	case point3 // и т.д.
}

// Перечисление с Raw значением типа String
enum L8StringPoints: String {
	case point1 = "p1"
	case point2 = "p2"
	case point3 = "p3"
}

// RawRepresentable позволяет указать Raw значения к перечислениям, где по умоланию этого нет
enum L8TrapezaType: RawRepresentable {
	// указываем тип Raw значений перечисления
	typealias RawValue = String
	
	// по протоколу каждая опция должна вернуть Raw значение указанного типа(мы указали тип String)
	var rawValue: String {
		switch self {
		case .breakfast:
			return "breakfast"
		case .lunch:
			return "lunch"
		case .dinner:
			return "dinner"
		}
	}

	// по протоколу нужно создать опцию из переданного Raw значения. Если Raw значение неизвестное, то вернуть nil
	init?(rawValue: String) {
		switch rawValue {
		case "breakfast":
			// тут я пытался вернуть нужную опцию, а надо было просто присвоить ее в self
			self = .breakfast(coffee: true, eggsCount: 1)
		case "lunch":
			self = .lunch(soup: true)
		case "dinner":
			self = .dinner
		default:
			return nil
		}
	}
	
	case breakfast(coffee: Bool, eggsCount: Int)
	case lunch(soup: Bool)
	case dinner
}

// Generic позволяют использовать класс/структуру для работы с разными типами данных т.о. не нужно писать классы/структуры для каждого типа данных
// T - условное обозначение типа. К примеру Int, Double
// Тип указывается в угловых скобках, например L8GenericPoint<Int>. Таким образом переменные x и y будут типа Int
// Comparable - означает что тип должен быть сравниваемый(для функции maxXorY())
struct L8GenericPoint<T: Comparable> {
	var x: T
	var y: T
	
	// Возвращаемый тип функции будет таким же, как T
	func maxXorY() -> T {
		if x > y {
			return x
		}
		return y
	}
}
