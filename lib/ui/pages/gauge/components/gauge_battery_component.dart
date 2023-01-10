import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:untitled/core/app_style.dart';
import 'package:untitled/data/models/gauge_battery.dart';
import 'package:untitled/ui/pages/gauge/widgets/title_indicator_widget.dart';
import 'package:untitled/ui/widgets/sky_box.dart';

class GaugeBatteryComponent extends StatelessWidget {
  const GaugeBatteryComponent({
    Key? key,
    required this.gaugeData,
    required this.data,
  }) : super(key: key);

  final List<GaugeBattery> gaugeData;
  final GaugeBattery data;

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
                      maximum: 15,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 4, color: Colors.red),
                        GaugeRange(
                            startValue: 4, endValue: 15, color: Colors.green)
                      ],
                      annotations: const <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text(
                            '9 V',
                            style: TextStyle(fontSize: 16),
                          ),
                          angle: 90,
                          positionFactor: 0.5,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        // NeedlePointer(value: 7),
                        NeedlePointer(value: double.parse(data.data!))
                      ],
                    ),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TitleIndicatorWidget(
                color: Colors.red,
                title: 'Low',
              ),
              SizedBox(width: 24),
              TitleIndicatorWidget(
                color: Colors.green,
                title: 'Normal',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Battery Voltage (V)',
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
