
import UserNotifications

class LocalNotificationsService {
    
    private let center = UNUserNotificationCenter.current()
    
    func registeForLatestUpdatesIfPossible() {
        center.requestAuthorization(options: [.sound, .badge, .provisional]) {access, error in
            if access {
                self.registerNotification()
            }
        }
    }
    
    private func registerNotification() {
        let content = UNMutableNotificationContent()
        content.sound = .defaultCritical
        content.title = "Проверьте обновления!"
        content.body = "Вдруг там что-то интересное, а вы всё пропустите! 😉"
        
        var time = DateComponents()
        time.hour = 19
        time.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        center.add(request)
    }
}



//Задача 2*(Со звездочкой):
//
//Добавьте в LocalNotificationsService делегат UNNotificationCenterDelegate
//Добавьте метод func registerUpdatesCategory()
//Внутри метода создайте категорию с идентификатором "updates"
//Добавьте в нее любое действие на Ваш выбор
//Зарегистрируйте ее в центре
//Внесите вызов метода registerUpdatesCategory() в начало метода registerForLatestUpdatesIfPossible
//В месте, где создается локальное уведомление, добавьте уведомлению принадлежность к категории и делегат
//Реализуйте метод func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void), в котором будет выполняться Ваше действие для категории (действие на Ваш выбор)
