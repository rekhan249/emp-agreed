import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emp_agreement/errors/exceptions.dart';
import 'package:emp_agreement/models/get_emp_model.dart';
import 'package:emp_agreement/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SearchControllerProvider with ChangeNotifier {
  final List<Employee> _filteredEmpData = [];
  List<Employee> get filteredEmpData => _filteredEmpData;
  Future<void> searchInData({String? querySearch}) async {
    String url =
        "${ApiservicesContants.baseUrl}${ApiservicesContants.searchApi}search=$querySearch&from_date=$querySearch&to_date=$querySearch";

    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.toString().isNotEmpty) {
        var jsonRespose = jsonDecode(response.body.toString());

        EmpGetsAll empGetsAll = EmpGetsAll.fromJson(jsonRespose);
        _filteredEmpData.addAll(empGetsAll.data);

        if (kDebugMode) {
          print(jsonRespose);
        }
      }
    } on RemoteException catch (e) {
      Fluttertoast.showToast(msg: e.dioException.toString());
    }
  }
}
