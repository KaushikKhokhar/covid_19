import 'package:flutter/material.dart';

import '../constants.dart';
import '../world_information/world_information.dart';

class Details extends StatelessWidget {
  final String country;
  final String image;
  final int cases;
  final int recovered;
  final int death;
  final int critical;
  final int todayRecovered;

  const Details(
      {super.key,
      required this.country,
      required this.image,
      required this.cases,
      required this.recovered,
      required this.death,
      required this.critical,
      required this.todayRecovered});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.grey[200],
          title: Text(
            country,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.045),
                    child: Card(
                      child: Column(
                        children: [
                          WorldDataInformation(
                            title: Constants.cases,
                            value: cases.toString(),
                          ),
                          WorldDataInformation(
                            title: Constants.recovered,
                            value: recovered.toString(),
                          ),
                          WorldDataInformation(
                            title: Constants.death,
                            value: death.toString(),
                          ),
                          WorldDataInformation(
                            title: Constants.critical,
                            value: critical.toString(),
                          ),
                          WorldDataInformation(
                            title: Constants.todayRecovered,
                            value: todayRecovered.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(image),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
