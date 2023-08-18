import 'package:covid_19_application/word_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.totalDeaths,
  });

  final String name, image;

  final int totalCases, totalRecovered, active, critical, todayRecovered, test, totalDeaths;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .06),
                    ReUsableRow(title: 'Cases', value: widget.totalCases.toString()),
                    ReUsableRow(title: 'Cases', value: widget.totalCases.toString()),
                    ReUsableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                    ReUsableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                    ReUsableRow(title: 'Critical', value: widget.critical.toString()),
                    ReUsableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
