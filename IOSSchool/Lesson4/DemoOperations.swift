//
//  DemoOperations.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 09.11.2020.
//

import UIKit

class DemoImageLoadOperation: Operation {

	private var completion:((_ image: UIImage?) -> Void)?
	private var isFinishedFlag = false
	private var isExecutingFlag = false
	
	override var isFinished: Bool {
		return isFinishedFlag
	}
	override var isExecuting: Bool {
		return isExecutingFlag
	}
	
	private let url: String
	init(url: String, completion:@escaping (_ image: UIImage?) -> Void) {
		self.url = url
		self.completion = completion
		super.init()
	}
	
	override func main() {
		// KVO отправляем уведомление что собираемся менять состояние isExecuting
		self.willChangeValue(forKey: "isExecuting")
		self.isExecutingFlag = true
		// KVO отправляем уведомление что поменяли состояние isExecuting
		self.didChangeValue(forKey: "isExecuting")
		
		var request = URLRequest(url: URL(string: url)!)
		let session = URLSession(configuration: URLSessionConfiguration.default)
		request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
		let task = session.dataTask(with: request) { (data, response, error) in
			// KVO отправляем уведомление что собираемся менять состояние isExecuting
			self.willChangeValue(forKey: "isFinished")
			self.isFinishedFlag = true
			self.didChangeValue(forKey: "isFinished")
			
			self.willChangeValue(forKey: "isExecuting")
			self.isExecutingFlag = false
			self.didChangeValue(forKey: "isExecuting")
			if let data = data {
				self.completion?(UIImage(data: data))
			} else {
				self.completion?(nil)
			}
			
		}
		task.resume()
	}
}
