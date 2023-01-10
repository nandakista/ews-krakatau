import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/data/models/data.dart';
import 'package:untitled/data/models/gauge_battery.dart';
import 'package:untitled/data/models/gauge_rasp.dart';

import 'components/graph_component_battery.dart';
import 'components/graph_component_humidity.dart';
import 'components/graph_component_pressure.dart';
import 'components/graph_component_sea.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Data> dataPressure = [];
  List<Data> dataHumidity = [];
  List<Data> dataTemp = [];
  DateTime now = DateTime.now();


  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), updateDataSource);
    super.initState();
    refresh();
    timeNow();
  }

  void updateDataSource(Timer timer) {
    setState(() {});
  }


  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void timeNow() {
    setState(() {
      now = DateTime.now();
    });
    Future.delayed(const Duration(seconds: 5), () {
      timeNow();
    });
  }

  void refresh() async {
    try {
      try {
        Data newPressure = Data(
            value: Random().nextInt(2000).toString(),
            timeStamp: DateTime.now());
        dataPressure.add(newPressure);
        if (dataPressure.length > 50) {
          dataPressure.removeAt(0);
        }
        dataPressure[dataPressure.length - 1];

        Data newHumidity = Data(
            value: Random().nextInt(100).toString(), timeStamp: DateTime.now());
        dataHumidity.add(newHumidity);
        if (dataHumidity.length > 10) {
          dataHumidity.removeAt(0);
        }
        dataHumidity[dataHumidity.length - 1];

        Data newTemp = Data(
            value: Random().nextInt(100).toString(), timeStamp: DateTime.now());
        dataTemp.add(newTemp);
        if (dataTemp.length > 10) {
          dataTemp.removeAt(0);
        }
        dataTemp[dataTemp.length - 1];

        setState(() {});
      } catch (e) {
        debugPrint(e.toString());
      }

      setState(() {});
      Future.delayed(const Duration(seconds: 5), () async {
        refresh();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            GraphComponentSeaWaterLevel(
              chartData: dataPressure,
              yTitle: 'Sea Water Level (Cm)',
            ),
            const SizedBox(height: 12),
            GraphComponentBattery(
              chartData: dataTemp,
              yTitle: 'Battery Voltage (V)',
            ),
            const SizedBox(height: 12),
            GraphComponentHumidity(
              chartData: dataHumidity,
              yTitle: 'Air Humidity (%)',
            ),
            const SizedBox(height: 12),
            GraphComponentPressure(
              chartData: dataPressure,
              yTitle: 'Air Pressure (hPa)',
            ),
          ],
        ),
      ),
    );
  }
}
