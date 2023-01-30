import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/pages/chart/cart_controller.dart';

import 'components/graph_component_battery.dart';
import 'components/graph_component_humidity.dart';
import 'components/graph_component_pressure.dart';
import 'components/graph_component_sea.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentSeaWaterLevel(
                chartData: controller.dataPressure.value,
                yTitle: 'Sea Water Level (Cm)',
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentBattery(
                chartData: controller.dataTemp.value,
                yTitle: 'Battery Voltage (V)',
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentHumidity(
                chartData: controller.dataHumidity.value,
                yTitle: 'Air Humidity (%)',
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => GraphComponentPressure(
                chartData: controller.dataPressure.value,
                yTitle: 'Air Pressure (hPa)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
