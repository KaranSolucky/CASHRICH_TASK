import 'dart:convert';
import 'package:cashrich_karan_task/model/list_data_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UserListDataProvider with ChangeNotifier {
  MyListModel? myListModel;
  UserListDataProvider();
  Future<dynamic> getData(BuildContext context) async {
    var response = await http.get(
        Uri.parse(
            "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC,ETH,LTC"),
        headers: {"X-CMC_PRO_API_KEY": "27ab17d1-215f-49e5-9ca4-afd48810c149"});
    myListModel = MyListModel.fromJson(json.decode(response.body));
    return myListModel;
  }

  setModelData(MyListModel myListModel) {
    myListModel = myListModel;
    notifyListeners();
  }

  MyListModel? getModelData() {
    return myListModel;
  }
}
