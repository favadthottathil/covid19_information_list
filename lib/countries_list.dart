import 'package:covid_19_application/Services/states_data.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatelessWidget {
  CountriesList({super.key});

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
                  return const Text(
                    'Loading....',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Image(
                              image: NetworkImage(
                                snapshot.data![index]['countryInfo']['flag'],
                              ),
                            ),
                          )
                        ],
                      );
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
