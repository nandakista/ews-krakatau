import 'package:flutter/material.dart';
import 'package:untitled/core/app_style.dart';
import 'package:untitled/ui/widgets/sky_box.dart';

class DataWrapperWidget extends StatelessWidget {
  const DataWrapperWidget({
    Key? key,
    required this.data,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String data;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SkyBox(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Center(
            child: (data == '0')
                ? const CircularProgressIndicator()
                : Text(
                    data,
                    style: AppStyle.headline0.copyWith(color: color),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppStyle.subtitle3.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
