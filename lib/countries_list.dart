import 'package:covid_19_application/Services/states_data.dart';
import 'package:covid_19_application/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatusService service = StatusService();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search With Country Name',
                hintStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: service.fetchCountryData(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(height: 50, width: 50, color: Colors.white),
                              title: Container(height: 10, width: 89, color: Colors.white),
                              subtitle: Container(height: 10, width: 89, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final String imageLink = snapshot.data![index]['countryInfo']['flag'];
                      final String name = snapshot.data![index]['country'];

                      if (searchController.text.isEmpty) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                name: name,
                                image: imageLink,
                                totalCases: snapshot.data![index]['cases'],
                                totalRecovered: snapshot.data![index]['recovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['tests'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                critical: snapshot.data![index]['critical'],
                                
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: imageLink.isNotEmpty
                                    ? Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                          imageLink,
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                      ),
                                title: Text(
                                  snapshot.data![index]['country'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (name.toLowerCase().contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            ListTile(
                              leading: imageLink.isNotEmpty
                                  ? Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                        imageLink,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.white,
                                    ),
                              title: Text(
                                snapshot.data![index]['country'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
