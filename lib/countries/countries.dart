import 'package:covid_19/countries/model/countries_model.dart';
import 'package:covid_19/countries/services/countries_services.dart';
import 'package:covid_19/details/details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.grey[200],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _searchController,
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Search with country name',
                    contentPadding: const EdgeInsets.only(left: 16),
                    hintStyle: const TextStyle(color: Colors.black38),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: FutureBuilder(
                  future: CountriesServices().getCountriesData(),
                  builder:
                      (context, AsyncSnapshot<List<CountriesModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var name = snapshot.data![index].country;
                            var countriesData = snapshot.data![index];
                            if (_searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Details(
                                            country: countriesData.country,
                                            image:
                                                countriesData.countryInfo.flag,
                                            cases: countriesData.cases,
                                            recovered: countriesData.recovered,
                                            death: countriesData.deaths,
                                            critical: countriesData.critical,
                                            todayRecovered:
                                                countriesData.todayRecovered,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                            countriesData.countryInfo.flag,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(countriesData.country,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              countriesData.cases.toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Divider(),
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                _searchController.text.toLowerCase())) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Details(
                                        country: countriesData.country,
                                        image: countriesData.countryInfo.flag,
                                        cases: countriesData.cases,
                                        recovered: countriesData.recovered,
                                        death: countriesData.deaths,
                                        critical: countriesData.critical,
                                        todayRecovered:
                                            countriesData.todayRecovered,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                            countriesData.countryInfo.flag,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(countriesData.country,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              countriesData.cases.toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.black26,
                            highlightColor: Colors.white,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Container(
                                    height: 10,
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
