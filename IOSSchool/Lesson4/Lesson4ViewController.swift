//
//  Lesson4ViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 09.11.2020.
//

import UIKit

// Для использования свифт классов/кода в Objective-C классах/коде нужно импортировать заголовочный файл #import "<Название проекта>-Swift.h"
// #import "IOSSchool-Swift.h"


@objc class Lesson4ViewController: UIViewController {

// objc	NSOperationQueue* operationQueue
	private var operationQueue: OperationQueue!
	
//	@IBOutlet указывает на то, что объект будет создан в Storyboard
	@IBOutlet private var activityView: UIActivityIndicatorView!
	@IBOutlet private var imageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		DispatchQueue.global().async {
			// выполнится в глобальном потоке
		}
		// можно задать приоритет выполнения
//		DispatchQueue.global(qos: <#T##DispatchQoS.QoSClass#>)

		operationQueue = OperationQueue()
		operationQueue.name = "com.iosschool.demooperations"
		operationQueue.maxConcurrentOperationCount = 1	// количество операций выполняемых одновременно
	}
	
	// @objc указывает на то, что метод будет доступен классам написанным на Objective-C(например в AppDelegate.m
	@objc func configure() {
		print("view controller configured")
	}

	// IBAction указывает на то, что метод вызовется нажатием на кнопку
	@IBAction private func loadButtonPressed(_ sender: Any) {
		loadImage()
	}
	
	@IBAction private func cancelButtonPressed(_ sender: UIButton) {
		// отменяем все операции
		operationQueue.cancelAllOperations()
	}
	
	private func loadImage() {
		activityView.startAnimating()
		let operation1 = DemoImageLoadOperation(url: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-trade-in-202010?wid=3012&hei=1582&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1601496902000") { image in
// objc		dispatch_async(get_main_queue, {
			self.showImage(image)
		}
		let operation2 = DemoImageLoadOperation(url: "https://www.apple.com/newsroom/images/values/corporate/standard/Apple_google-partner-on-covid-19-contact-tracing-technology_04102020_inline.jpg.large_2x.jpg") { image in
			self.showImage(image)
		}
		let operation3 = DemoImageLoadOperation(url: "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/watch-shop-se-hero-202009_GEO_RU?wid=1388&hei=962&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1602700400000") { image in
			self.showImage(image)
		}
		
		// простая блок-операция скрытия индикатора загрузки, должна выполниться в последнюю очередь
		let finishOperation = BlockOperation {
			DispatchQueue.main.async {
			 self.activityView.stopAnimating()
			}
		}
		
		// настраиваем зависимости, чтобы operation1 выполнилась после operation2
		operation1.addDependency(operation2)
		// настраиваем зависимости, чтобы operation2 выполнилась после operation3
		operation2.addDependency(operation3)
		// будет выполнено в таком порядке: operation3, operation2, operation1
		
		// настраиваем зависимости, чтобы finishOperation выполнилась после всех остальных
		// в случае если operationQueue.maxConcurrentOperationCount = 1, можно оставить зависимость только с последней операции finishOperation.addDependency(operation1)
		// если же operationQueue.maxConcurrentOperationCount >= 2, то нужно явно указать зависимость от всех операций т.к. они будут выполняться в разном порядке и нельзя определить какая операция будет выполнена последней
		finishOperation.addDependency(operation1)
		finishOperation.addDependency(operation2)
		finishOperation.addDependency(operation3)
		
		operationQueue.addOperation(operation1)
		operationQueue.addOperation(operation2)
		operationQueue.addOperation(operation3)
		operationQueue.addOperation(finishOperation)

		// можно добавить сразу блок в очередь, но тут не настроить зависимости
//		operationQueue.addOperation {
//			DispatchQueue.main.async {
//			 self.activityView.stopAnimating()
//			}
//		}
	}
	
	private func showImage(_ image: UIImage?) {
		DispatchQueue.main.async {
			self.imageView.image = image
		}
	}
}
