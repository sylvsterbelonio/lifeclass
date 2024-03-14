import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final String colorTheme;
  final Function onTap;
  final double lovePercentage;
  final double visionPercentage;
  final double dailyVersePercentage;

  const Dashboard({super.key,required this.colorTheme,required this.onTap,required this.lovePercentage,required this.visionPercentage,required this.dailyVersePercentage});


  @override
  Widget build(BuildContext context) {
    return const Text('Dashboard');
  }
}
