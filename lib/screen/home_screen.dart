import 'package:cashrich_karan_task/Utils/hexcolor.dart';
import 'package:cashrich_karan_task/model/list_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/list_data_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  MyListModel myListModel = MyListModel();
  @override
  void initState() {
    getList(context);
    Future.delayed(Duration.zero, () async {
      getList(context);
      refreshList();
    });
    super.initState();
  }

  Future<void> getList(BuildContext context) async {
    myListModel =
        await Provider.of<UserListDataProvider>(context, listen: false)
            .getData(context);

    if (!mounted) return;
    print(myListModel);

    Provider.of<UserListDataProvider>(context, listen: false)
        .setModelData(myListModel);
    if (myListModel != null) {
      setState(() {});
    }
  }

  var lastPrice = 0;
  Color color = Colors.transparent;
  double? percent;
  // Stream<MyListModel> btcStream() async* {
  //   while (true) {
  //     await Future.delayed(Duration(milliseconds: 300));
  //     MyListModel myListModel = getList(context);
  //     yield myListModel;
  //   }
  // }
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    getList(context);
    print("refresh working");

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "CoinRich",
          style: TextStyle(fontFamily: "Roboto"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                refreshList();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Scaffold(
          backgroundColor: HexColor("#383434"),
          body: myListModel.status != null
              ? RefreshIndicator(
                  onRefresh: refreshList,
                  key: refreshKey,
                  child: Container(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.pie_chart_rounded,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Show Chart",
                              style: TextStyle(
                                  color: Colors.yellow, fontFamily: "Roboto"),
                            ),
                            Spacer(),
                            Text(
                              "Count 3",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //if data is coming in List then we can use LISTVIEW BUILDER FOR ITEM COUNT
                      //Hence BTC, ETH not coming in LIST so i have used SEPERATE WIDGET

                      // Container(
                      //   child: ListView.builder(
                      //       itemCount: 3,
                      //       physics: NeverScrollableScrollPhysics(),
                      //       shrinkWrap: true,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             height: 80,
                      //             width: MediaQuery.of(context).size.width,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 color: Colors.black),
                      //             child: Column(children: [
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                       child: Text(
                      //                     myListModel!.data!.bTC!.slug.toString(),
                      //                     style: TextStyle(color: Colors.yellow),
                      //                   ))
                      //                 ],
                      //               )
                      //             ]),
                      //           ),
                      //         );
                      //       }),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    myListModel.data!.bTC!.slug.toString(),
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 20),
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                          myListModel.data!.bTC!.quote!.uSD!
                                                      .percentChange24h! <
                                                  0
                                              ? Icons.arrow_downward_rounded
                                              : Icons.arrow_downward_rounded,
                                          color: myListModel.data!.bTC!.quote!
                                                      .uSD!.percentChange24h! <
                                                  0
                                              ? Colors.red
                                              : Colors.green),
                                      Text(
                                        double.parse(
                                                "${myListModel.data!.bTC!.quote!.uSD!.percentChange24h}")
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  )),
                                  Spacer(),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: HexColor("#383434"),
                                    ),
                                    child: Center(
                                        child: Text(
                                      myListModel.data!.bTC!.name
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price : \$${double.parse(myListModel.data!.bTC!.quote!.uSD!.price.toString()).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.yellow),
                                        color: Colors.yellow.withOpacity(.2)),
                                    child: Text(
                                      "Rank : ${double.parse(myListModel.data!.bTC!.cmcRank.toString()).toStringAsFixed(0)}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.yellow,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    myListModel.data!.eTH!.slug.toString(),
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 20),
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                          myListModel.data!.eTH!.quote!.uSD!
                                                      .percentChange24h! <
                                                  0
                                              ? Icons.arrow_downward_rounded
                                              : Icons.arrow_downward_rounded,
                                          color: myListModel.data!.eTH!.quote!
                                                      .uSD!.percentChange24h! <
                                                  0
                                              ? Colors.red
                                              : Colors.green),
                                      Text(
                                        double.parse(
                                                "${myListModel.data!.eTH!.quote!.uSD!.percentChange24h}")
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  )),
                                  Spacer(),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: HexColor("#383434"),
                                    ),
                                    child: Center(
                                        child: Text(
                                      myListModel.data!.eTH!.name
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price : \$${double.parse(myListModel.data!.eTH!.quote!.uSD!.price.toString()).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.yellow),
                                        color: Colors.yellow.withOpacity(.2)),
                                    child: Text(
                                      "Rank : ${double.parse(myListModel.data!.eTH!.cmcRank.toString()).toStringAsFixed(0)}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.yellow,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    myListModel.data!.lTC!.slug.toString(),
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 20),
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                          myListModel.data!.lTC!.quote!.uSD!
                                                      .percentChange24h! <
                                                  0
                                              ? Icons.arrow_downward_rounded
                                              : Icons.arrow_downward_rounded,
                                          color: myListModel.data!.lTC!.quote!
                                                      .uSD!.percentChange24h! <
                                                  0
                                              ? Colors.red
                                              : Colors.green),
                                      Text(
                                        double.parse(
                                                "${myListModel.data!.lTC!.quote!.uSD!.percentChange24h}")
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  )),
                                  Spacer(),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: HexColor("#383434"),
                                    ),
                                    child: Center(
                                        child: Text(
                                      myListModel.data!.lTC!.name
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price : \$${double.parse(myListModel.data!.lTC!.quote!.uSD!.price.toString()).toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.yellow),
                                        color: Colors.yellow.withOpacity(.2)),
                                    child: Text(
                                      "Rank : ${double.parse(myListModel.data!.lTC!.cmcRank.toString()).toStringAsFixed(0)}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.yellow,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  )),
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
