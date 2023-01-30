import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:untitled/data/models/data.dart';

class CartController extends GetxController {
  RxList<Data> dataPressure = <Data>[].obs;
  RxList<Data> dataHumidity = <Data>[].obs;
  RxList<Data> dataTemp = <Data>[].obs;
  DateTime now = DateTime.now();
  Timer? timer;

  @override
  void onInit() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      update();
    });
    timer;
    refreshData();
    timeNow();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void timeNow() {
    now = DateTime.now();
    Future.delayed(const Duration(seconds: 5), () {
      timeNow();
    });
  }

  void refreshData() async {
    try {
      updatePressure();
      updateHumidity();
      updateTemperature();

      Future.delayed(const Duration(seconds: 5), () async {
        refreshData();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updatePressure() {
    Data newPressure = Data(
      value: Random().nextInt(2000).toString(),
      timeStamp: DateTime.now(),
    );
    dataPressure.add(newPressure);
    if (dataPressure.length > 50) dataPressure.removeAt(0);
  }

  updateHumidity() {
    Data newHumidity = Data(
        value: Random().nextInt(100).toString(), timeStamp: DateTime.now());
    dataHumidity.add(newHumidity);
    if (dataHumidity.length > 10) dataHumidity.removeAt(0);
  }

  updateTemperature() {
    Data newTemp = Data(
        value: Random().nextInt(100).toString(), timeStamp: DateTime.now());
    dataTemp.add(newTemp);
    if (dataTemp.length > 10) dataTemp.removeAt(0);
  }
}
