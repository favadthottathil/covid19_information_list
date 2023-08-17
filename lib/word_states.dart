import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  final colorList = const [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              SizedBox(height: size.height * .01),
              PieChart(
                dataMap: const {
                  'Total': 20,
                  "Recovered": 15,
                  "Deaths": 5,
                },
                chartLegendSpacing: 50,
                ringStrokeWidth: 13,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  chartValueBackgroundColor: Colors.transparent,
                  chartValueStyle: TextStyle(color: Colors.white),
                ),
                legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.left,
                  legendTextStyle: TextStyle(color: Colors.white),
                ),
                animationDuration: const Duration(microseconds: 1200),
                chartType: ChartType.ring,
                colorList: colorList,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * .06),
                child: Card(
                  child: Column(
                    children: const [
                      ReUsableRow(title: 'total', value: '200'),
                      ReUsableRow(title: 'total', value: '200'),
                      ReUsableRow(title: 'total', value: '200'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  const ReUsableRow({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
              ),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
