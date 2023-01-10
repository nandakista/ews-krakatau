import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/data/models/gauge_battery.dart';
import 'package:untitled/data/models/gauge_rasp.dart';
import 'package:untitled/ui/pages/gauge/components/gauge_battery_component.dart';
import 'package:untitled/ui/pages/gauge/components/gauge_raspi_component.dart';

class GaugePage extends StatefulWidget {
  const GaugePage({Key? key}) : super(key: key);

  @override
  State<GaugePage> createState() => _GaugePageState();
}

class _GaugePageState extends State<GaugePage> {
  List<GaugeBattery> gaugeDataBattery = [];
  List<GaugeRasp> gaugeDataRaspi = [];

  GaugeBattery gaugeBattery = GaugeBattery(data: '0');
  GaugeRasp gaugeRaspi = GaugeRasp(data: '0');

  Timer? timer1;
  Timer? timer2;

  @override
  void initState() {
    timer1 = Timer.periodic(const Duration(seconds: 3), updateDataSource1);
    timer2 = Timer.periodic(const Duration(seconds: 3), updateDataSource2);
    timer1;
    timer2;
    super.initState();
  }

  void updateDataSource1(Timer timer) {
    try {
      GaugeBattery newGaugeData = GaugeBattery(
        data: (Random().nextInt(10) + 3).toString(),
      );

      gaugeDataBattery.add(newGaugeData);
      if (gaugeDataBattery.length > 59) {
        gaugeDataBattery.removeAt(0);
      }
      gaugeBattery = gaugeDataBattery[gaugeDataBattery.length - 1];
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateDataSource2(Timer timer) {
    try {
      GaugeRasp newGaugeRasp = GaugeRasp(
        data: (Random().nextInt(10) + 3).toString(),
      );
      gaugeDataRaspi.add(newGaugeRasp);
      if (gaugeDataRaspi.length > 70) {
        gaugeDataRaspi.removeAt(0);
      }
      gaugeRaspi = gaugeDataRaspi[gaugeDataRaspi.length - 1];
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    gaugeDataBattery.clear();
    timer1?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            GaugeBatteryComponent(
              gaugeData: gaugeDataBattery,
              data: gaugeBattery,
            ),
            const SizedBox(height: 12),
            GaugeRaspiComponent(
              gaugeData: gaugeDataRaspi,
              data: gaugeRaspi,
            )
          ],
        ),
      ),
    );
  }
}
