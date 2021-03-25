//
//  Lesson21ViewController.swift
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 17.03.2021.
//

import UIKit
import UserNotifications

class Lesson21ViewController: UITableViewController {

	// Действия в таблице
	enum LocalNotificationsRows: Int {
		case authorization
		case notification
		case alarmNotification
		case likeNotification
		case clear
		case updateBadge
		case removeBadge
	}
	
	// Категории пушей
	enum LocalNotificationCategory: String, CaseIterable {
		case alarm = "alarmCategory"
		case like = "likeCategory"
		
		// Все категории в виде сета UNNotificationCategory
		static var allCategories: Set<UNNotificationCategory> {
			// .map преобразует массив объектов в массив объектов с другим типом
			// в нашем случае преобразуем в UNNotificationCategory
			let allCategories = self.allCases.map { (category) -> UNNotificationCategory in
				return UNNotificationCategory(identifier: category.rawValue, actions: category.actions, intentIdentifiers: [], options: [])
			}
			// преобразуем массив в сет
			return Set(allCategories)
		}
		
		// Действия для категории
		private var actions: [UNNotificationAction] {
			switch self {
			case .alarm:
				let snoozeAction = UNNotificationAction(identifier: "SnoozeAlarm", title: "Snooze", options: [])
				let deleteAction = UNNotificationAction(identifier: "DeleteAlarm", title: "Delete", options: [.destructive])	// .destructive это красная кнопка
				return [snoozeAction, deleteAction]
			case .like:
				let likeAction = UNNotificationAction(identifier: "Like", title: "Like", options: [])
				let deleteAction = UNNotificationAction(identifier: "DeleteLike", title: "Delete", options: [.destructive])
				return [likeAction, deleteAction]
			}
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		// Ставим себя делегатом центра уведомлений, чтобы обрабатывать действия с пушами
		UNUserNotificationCenter.current().delegate = self
		// Регистрируем категории пушей, по которым будут определяться наборы действий(кнопок)
		// В дальнейшем в пуш достаточно указать категорию, чтобы определить набор действий на пуш
		UNUserNotificationCenter.current().setNotificationCategories(LocalNotificationCategory.allCategories)
    }
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let row = LocalNotificationsRows(rawValue: indexPath.row)!
		switch row {
		case .authorization:
			requestAuthorization()
		case .notification:
			showLocalNotification(message: "Simple local notification")
		case .alarmNotification:
			showLocalNotification(message: "Stand up! This is alarm notification", category: .alarm)
		case .likeNotification:
			showLocalNotification(message: "Local notification about new like", category: .like)
		case .clear:
			clearAllNotifications()
		case .updateBadge:
			// узнаем сколько есть доставленных уведомлений и указываем это количество на бадже приложения
			UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { (notifications) in
				// в главном потоке
				DispatchQueue.main.async {
					UIApplication.shared.applicationIconBadgeNumber = notifications.count
				}
			})
		case .removeBadge:
			// обнуляем количество уведомлений на бадже приложения
			UIApplication.shared.applicationIconBadgeNumber = 0
		}
	}
	
	// MARK: - Private Methods
	
	/// Запрос на пуши
	private func requestAuthorization() {
		// Смотрим текущие настройки пушей
		UNUserNotificationCenter.current().getNotificationSettings { (settings) in
			// и делаем запрос, если его еще не было
			if(settings.authorizationStatus == .notDetermined) {
				// Запрашиваем все типы уведомлений
				let options: UNAuthorizationOptions = [.alert, .badge, .sound]
				UNUserNotificationCenter.current().requestAuthorization(options: options) { (authorized, error) in
					// тут смотрим результат запроса. autorized = true если авторизован
				}
			}
		}
	}
	
	private func showLocalNotification(message: String, category: LocalNotificationCategory? = nil) {
		let content = UNMutableNotificationContent()
		content.title = message
//		content.subtitle = "Можно указать подзаголовок"
		content.body = message
		content.sound = UNNotificationSound.default
//		content.badge = 1	// Можно указать количество баджей, которое будет отображаться на иконке приложения
		
		// rawValue - это строковое значение опции. Например для like, это "likeCategory"
		if let category = category?.rawValue {
			// если указали категорию, указываем ее, чтобы указать какой набор действий(кнопок) нужен для этого пуша
			content.categoryIdentifier = category
		}
		
		// другие типы триггеров: UNLocationNotificationTrigger, UNCalendarNotificationTrigger
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(request) { (error) in
			if let error = error {
				print("Error \(error.localizedDescription)")
			}
		}
	}
	
	private func clearAllNotifications() {
		// Удаляем все доставленные уведомления
		UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
			UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: notifications.map({$0.request.identifier}))
		}
		// Можно удалить и так
//		UNUserNotificationCenter.current().removeAllDeliveredNotifications()
	}
}

extension Lesson21ViewController: UNUserNotificationCenterDelegate {
	// Обрабатываем действия пушей(кнопки)
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//		response.notification.request.content.categoryIdentifier
		switch response.actionIdentifier {
		case UNNotificationDismissActionIdentifier:
			print("Dismiss Action")
		case UNNotificationDefaultActionIdentifier:
			print("Default")
		case "SnoozeAlarm":
			showLocalNotification(message: "Snooze alarm", category: .alarm)
		case "DeleteAlarm":
			print("Delete Alarm")
		case "Like":
			print("Like")
		case "DeleteLike":
			print("Delete Like")
		default:
			print("Unknown action")
		}
		completionHandler()
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler([.badge, .sound, .banner])
	}
}
