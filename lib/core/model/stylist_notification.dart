class StylistNotification {
  bool? allNotification;
  bool? appointments;
  bool? reminders;
  bool? bookingAndAppont;
  bool? newService;
  String? id;

  StylistNotification({
    this.allNotification = false,
    this.appointments = false,
    this.reminders =false,
    this.bookingAndAppont = false,
    this.newService = false,
    this.id,
  });

  StylistNotification.fromJson(json, uid) {
    id = uid;
    allNotification = json['allNotifications'] ?? false;
    appointments = json['appointments'] ?? false;
    reminders = json['reminders'] ?? false;
    bookingAndAppont = json['bookingAndAppoint'] ?? false;
    newService = json['newService'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allNotifications'] = allNotification;
    data['appointments'] = appointments;
    data['reminders'] = reminders;
    data['bookingAndAppoint'] = bookingAndAppont;
    data['newService'] = newService;
    return data;
  }
}
