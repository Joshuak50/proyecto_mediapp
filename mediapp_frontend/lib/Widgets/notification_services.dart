import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService{
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(NotificationResponse notificationResponse) async{}

  static Future<void> init() async{
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/img");
    const DarwinInitializationSettings iOSinitializationSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iOSinitializationSettings
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse:onDidReceiveNotification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  }

  static Future<void> showInstantNotification(String title, String body) async {
    debugPrint("Intentando mostrar notificación instantánea: $title");
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_Id',
          'channel_Name',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }


  static Future<void> cancelNotificationsForMedicamento(int medicamentoId) async {
    // La lógica para cancelar notificaciones debe basarse en el ID del medicamento
    for (int i = 0; i < 100; i++) {  // 100 es un número arbitrario, depende de cuántas programaste
      int notificationId = (medicamentoId * 100) + i; // Mismo cálculo usado al programarlas
      await flutterLocalNotificationsPlugin.cancel(notificationId);
      print("❌ Notificación con ID $notificationId cancelada");
    }
  }

  static Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }



  static Future<void> scheduleNotification(String title, String body, DateTime scheduledDate, int id) async {
    // 🔥 Asegurar que las zonas horarias están inicializadas
    tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    // 🔄 Si la hora ya pasó, moverla al día siguiente
    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      tzScheduledDate = tzScheduledDate.add(const Duration(days: 1));
    }

    print("⏰ Intentando programar notificación para: $tzScheduledDate con ID: $id");

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, //Usar un ID único
      title,
      body,
      tzScheduledDate,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("✅ Notificación programada con éxito para: $tzScheduledDate con ID $id");
  }


}