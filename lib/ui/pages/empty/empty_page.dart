import 'package:flutter/material.dart';
import 'package:untitled/core/app_style.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 36),
        child: Column(
          children: [
            Image.asset('assets/img_empty.png'),
            const SizedBox(height: 12),
            Text(
              'Data Kosong',
              style: AppStyle.subtitle4.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text('Pilih lokasi terlebih', style: AppStyle.body2),
          ],
        ),
      ),
    );
  }
}
