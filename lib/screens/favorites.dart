import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knm_masjid_app/constants/Theme.dart';
import 'package:knm_masjid_app/controller/fav.controller.dart';
import 'package:knm_masjid_app/model/majid.dart';
import 'package:knm_masjid_app/widgets/drawer.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final favC = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      drawer: const MyDrawer.Drawer(currentPage: "Favorites"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
            future: favC.getFav(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Masjid>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                List<Masjid> data = snapshot.data!;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: 150,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/detailmasjid', arguments: data[index]);
                          },
                          child: Card(
                            elevation: 0.6,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6.0),
                                              bottomLeft: Radius.circular(6.0)),
                                          image: DecorationImage(
                                            image: AssetImage(data[index].image),
                                            fit: BoxFit.cover,
                                          ))),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index].address,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                              style: const TextStyle(
                                                  color: MyColors.header,
                                                  fontSize: 13)),
                                          const Spacer(),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "View More",
                                                style: TextStyle(
                                                    color: MyColors.primary,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ));
                  },
                  itemCount: data.length,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
