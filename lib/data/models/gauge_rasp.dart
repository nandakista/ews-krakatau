class GaugeRasp {
  String? data;

  GaugeRasp({this.data});

  factory GaugeRasp.fromJson(Map<String, dynamic> data) {
    return GaugeRasp(
      data: data['value'].toString(),
    );
  }
}
