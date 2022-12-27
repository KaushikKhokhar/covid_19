// ignore_for_file: must_be_immutable

import 'package:covid_19/constants.dart';
import 'package:covid_19/world_information/services/world_information_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'model/world_information_model.dart';

class WorldInformation extends StatefulWidget {
  const WorldInformation({Key? key}) : super(key: key);

  @override
  State<WorldInformation> createState() => _WorldInformationState();
}

class _WorldInformationState extends State<WorldInformation>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  final colorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
              future: WorldInformationServices().fetchWorldInformation(),
              builder:
                  (context, AsyncSnapshot<WorldInformationModel> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total': double.parse(
                            snapshot.data!.cases.toString(),
                          ),
                          'Recovered': double.parse(
                            snapshot.data!.recovered.toString(),
                          ),
                          'Deaths': double.parse(
                            snapshot.data!.deaths.toString(),
                          ),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        animationDuration: const Duration(seconds: 2),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        // color: Colors.grey[200],
                        child: Column(
                          children: [
                            WorldDataInformation(
                              title: Constants.total,
                              value: snapshot.data!.cases.toString(),
                            ),
                            WorldDataInformation(
                              title: Constants.deaths,
                              value: snapshot.data!.deaths.toString(),
                            ),
                            WorldDataInformation(
                              title: Constants.recovered,
                              value: snapshot.data!.recovered.toString(),
                            ),
                            WorldDataInformation(
                              title: Constants.active,
                              value: snapshot.data!.active.toString(),
                            ),
                            WorldDataInformation(
                              title: Constants.critical,
                              value: snapshot.data!.critical.toString(),
                            ),
                            WorldDataInformation(
                              title: Constants.todayDeaths,
                              value: snapshot.data!.todayDeaths.toString(),
                            ),
                            WorldDataInformation(
                              title: Constants.todayRecovered,
                              value: snapshot.data!.todayRecovered.toString(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff1aa260),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Track Countries',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _animationController,
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

class WorldDataInformation extends StatelessWidget {
  String title;
  String value;

  WorldDataInformation({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
