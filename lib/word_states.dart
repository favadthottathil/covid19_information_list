import 'package:covid_19_application/Services/states_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

// Screen displaying global COVID-19 statistics.
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  // Animation controller for chart animation.
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();

    // Dispose the animation controller.
    _controller.dispose();
  }

  // List of colors for chart segments.
  final colorList = const [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    StatusService service = StatusService();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              SizedBox(height: size.height * .01),
              // Display pie chart showing COVID-19 statistics.
              FutureBuilder(
                future: service.fetchData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
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
                        const SizedBox(height: 20),
                        // Card displaying detailed COVID-19 statistics.
                        Card(
                          child: Column(
                            children: [
                              ReUsableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              ReUsableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReUsableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReUsableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReUsableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReUsableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReUsableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Button to navigate to country-specific tracking.
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Track Countries',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A reusable row displaying a statistic title and value.
class ReUsableRow extends StatelessWidget {
  const ReUsableRow({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Column(
          children: [
            // Row displaying the title and corresponding value.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(value, style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
