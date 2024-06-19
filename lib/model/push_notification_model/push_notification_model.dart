// class PushNotificationModel{
//   String? title;
//   String? body;
//   String? dataTitle;
//   String? dataBody;
//   PushNotificationModel({this.title,this.body,this.dataBody,this.dataTitle});
// }
class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.userRole,
  });
  String? title;
  String? body;
  String? userRole;
}