class GaugeBattery {
  String? data;

  GaugeBattery({this.data});

  factory GaugeBattery.fromJson(Map<String, dynamic> data) {
    return GaugeBattery(
      data: data['value'].toString(),
    );
  }
}
