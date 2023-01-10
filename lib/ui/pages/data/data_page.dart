import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/core/app_color.dart';
import 'package:untitled/data/models/data.dart';
import 'package:untitled/ui/pages/data/widgets/data_wrapper_widget.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            DataWrapperWidget(
              title: 'Air Pressure',
              color: Colors.red,
              // data: '1012 hF',
              data: (dataPressure.length >= 2)
                  ? "${dataPressure[dataPressure.length - 1].value} hF"
                  : "0",
            ),
            const SizedBox(height: 8),
            DataWrapperWidget(
              title: 'Air Temperature',
              color: AppColors.teal,
              data: (dataTemp.length >= 2)
                  ? "${dataTemp[dataTemp.length - 1].value} °C"
                  : "0",
            ),
            const SizedBox(height: 8),
            DataWrapperWidget(
              title: 'Air Humidity',
              color: Colors.green,
              data: (dataHumidity.length >= 2)
                  ? "${dataHumidity[dataHumidity.length - 1].value} %"
                  : "0",
            ),
          ],
        ),
      ),
    );
  }
}
