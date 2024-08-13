import 'dart:convert';
import 'package:emp_agreement/utils/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:emp_agreement/errors/exceptions.dart';
import 'package:emp_agreement/models/emp_model.dart';
import 'package:emp_agreement/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateContollerProvider with ChangeNotifier {
  Future<void> submittedUpdatationAgreement(
    BuildContext context,
    TextEditingController employeeName,
    TextEditingController role,
    TextEditingController startDate,
    TextEditingController endDate,
    TextEditingController salary,
    TextEditingController terms,
    TextEditingController department,
    TextEditingController manager,
    int? id,
  ) async {
    OtherDetails otherDetails = OtherDetails(
        department: department.text.trim(), manager: manager.text.trim());
    EmployeeInfoModel employeeInfoModel = EmployeeInfoModel(
        employeeName: employeeName.text.trim(),
        role: role.text.trim(),
        startDate: startDate.text,
        endDate: endDate.text,
        salary: salary.text.trim(),
        terms: terms.text.trim(),
        otherDetails: otherDetails);
    String url = ApiservicesContants.baseUrl +
        ApiservicesContants.updateEmpApi +
        id.toString();

    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      var response = await http.put(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(employeeInfoModel.toJson()));

      if (response.toString().isNotEmpty) {
        var jsonRespose = jsonDecode(response.body.toString());

        if (kDebugMode) {
          print(jsonRespose);
        }

        Fluttertoast.showToast(msg: "Emp agreement update Successfully");

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RouteGenerator.readEmp);
      }
    } on RemoteException catch (e) {
      Fluttertoast.showToast(msg: e.dioException.toString());
    }
  }
}
