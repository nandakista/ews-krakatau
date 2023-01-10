import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:untitled/core/app_style.dart';
import 'package:untitled/data/models/gauge_rasp.dart';
import 'package:untitled/ui/pages/gauge/widgets/title_indicator_widget.dart';
import 'package:untitled/ui/widgets/sky_box.dart';

class GaugeRaspiComponent extends StatelessWidget {
  const GaugeRaspiComponent({
    Key? key,
    required this.gaugeData,
    required this.data,
  }) : super(key: key);

  final List<GaugeRasp> gaugeData;
  final GaugeRasp data;

  @override
  Widget build(BuildContext context) {
    return SkyBox(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      borderRadius: 24,
      child: Column(
        children: [
          (gaugeData.isEmpty)
              ? const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 7,
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 2,
                      color: Colors.green),
                  GaugeRange(
                      startValue: 2,
                      endValue: 4,
                      color: Colors.orange),
                  GaugeRange(
                      startValue: 4, endValue: 7, color: Colors.red)
                ],
                annotations: const <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '11 °C',
                      style: TextStyle(fontSize: 16),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
                pointers: <GaugePointer>[
                  // NeedlePointer(value: 1),
                  NeedlePointer(value: double.parse(data.data!))
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TitleIndicatorWidget(color: Colors.green, title: 'Cold'),
              SizedBox(width: 24),
              TitleIndicatorWidget(color: Colors.orange, title: 'Warm'),
              SizedBox(width: 24),
              TitleIndicatorWidget(color: Colors.red, title: 'Hot'),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Raspi Temp (°C)',
              style: AppStyle.subtitle4.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
