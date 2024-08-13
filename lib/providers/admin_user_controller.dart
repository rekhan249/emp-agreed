import 'dart:convert';
import 'package:emp_agreement/services/api_services.dart';
import 'package:emp_agreement/utils/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:emp_agreement/errors/exceptions.dart';
import 'package:emp_agreement/models/admin_model.dart';
import 'package:emp_agreement/services/network_client.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUserProvider with ChangeNotifier {
  NetworkClient networkClient = NetworkClient();
  Future<void> submittedLoginForm(
    BuildContext context,
    TextEditingController email,
    TextEditingController password,
  ) async {
    AdminUserModel adminUserModel = AdminUserModel(
        email: email.text.trim(), password: password.text.trim());

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String url = ApiservicesContants.baseUrl + ApiservicesContants.loginApi;

    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: json.encode(adminUserModel.toMap()));

      if (response.toString().isNotEmpty) {
        var jsonRespose = jsonDecode(response.body.toString());
        String? token = jsonRespose["accessToken"];
        await preferences.setString("token", token!);
        if (kDebugMode) {
          print("Admin : $token");
        }
        Fluttertoast.showToast(msg: "Admin Login Successfully");

        email.clear();
        password.clear();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RouteGenerator.createEmp);
      }
    } on RemoteException catch (e) {
      Fluttertoast.showToast(msg: e.dioException.toString());
    }
  }
}
