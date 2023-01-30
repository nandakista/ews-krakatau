import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/data/models/data.dart';
import 'package:untitled/data/models/server/water_level.dart';
import 'package:untitled/ui/widgets/sky_box.dart';

class GraphComponentSeaWaterLevel extends StatelessWidget {
  final List<WaterLevel> chartData;
  final String yTitle;

  const GraphComponentSeaWaterLevel({
    Key? key,
    required this.chartData,
    required this.yTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkyBox(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 370,
      child: (chartData.isNotEmpty)
          ? Column(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Sea Water Level",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateFormat('d MMM yyy, HH:mm').format(DateTime.now()),
                        // convertDateTime(chartData[0].timeStamp!),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SfCartesianChart(
                  series: <LineSeries<WaterLevel, DateTime>>[
                    LineSeries<WaterLevel, DateTime>(
                      dataSource: chartData,
                      color: const Color.fromARGB(255, 0, 26, 255),
                      xValueMapper: (WaterLevel data, _) => data.timeStamp,
                      yValueMapper: (WaterLevel data, _) => data.tinggi,
                    )
                  ],
                  primaryXAxis: DateTimeAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      title: AxisTitle(text: 'Time ')),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: yTitle),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
