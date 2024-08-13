import 'dart:convert';
import 'dart:developer';
import 'package:emp_agreement/errors/exceptions.dart';
import 'package:emp_agreement/models/get_emp_model.dart';
import 'package:emp_agreement/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetAllEmployees with ChangeNotifier {
  bool _isloader = false;
  get isloader => _isloader;
  final List<Employee> _employeeList = [];
  final List<Employee> _filterdEmpList = [];

  List<Employee> get employeeList =>
      _filterdEmpList.isNotEmpty ? _filterdEmpList : _employeeList;

  /// Gets All employee data
  Future<void> getsAllEmployees() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');
    String url = ApiservicesContants.baseUrl + ApiservicesContants.getAllEmpApi;
    _isloader = true;
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": 'application/json',
        },
      );

      var jsonRespose = json.decode(response.body.toString());
      if (response.toString().isNotEmpty) {
        EmpGetsAll empGetsAll = EmpGetsAll.fromJson(jsonRespose);
        _employeeList.addAll(empGetsAll.data);
        notifyListeners();
      }
      _isloader = false;
    } catch (e) {
      log(e.toString());
    }
  }

  /// Get Single Employee data

  Future<List<Employee>> getsEmployee({int? id}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // ignore: unused_local_variable
    String? token = preferences.getString('token');
    String url = ApiservicesContants.baseUrl +
        ApiservicesContants.getEmpApi +
        id.toString();
    List<Employee>? singlEmployee = [];
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": 'application/json',
        },
      );

      Map<String, dynamic> jsonRespose = json.decode(response.body);
      Employee employee = Employee.fromJson(jsonRespose['data']);
      singlEmployee.add(employee);
    } catch (e) {
      log(e.toString());
    }
    return singlEmployee;
  }

  /// search api Acessing

  Future<void> searchInData({String? querySearch}) async {
    String url =
        "${ApiservicesContants.baseUrl}${ApiservicesContants.searchApi}search=${querySearch!.toLowerCase()}&from_date=$querySearch&to_date=$querySearch";

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
        _filterdEmpList.addAll(empGetsAll.data);
        notifyListeners();

        if (kDebugMode) {
          print(jsonRespose);
        }
      }
    } on RemoteException catch (e) {
      Fluttertoast.showToast(msg: e.dioException.toString());
    }
  }

  /// Delete Api Accessing

  Future<void> submittedDeletionAgreement(BuildContext context,
      {int? id}) async {
    String url = ApiservicesContants.baseUrl +
        ApiservicesContants.deleteEmpApi +
        id.toString();

    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.toString().isNotEmpty) {
        var jsonRespose = jsonDecode(response.body.toString());
        _employeeList.removeWhere((item) => item.recordId == id);
        _filterdEmpList.removeWhere((item) => item.recordId == id);
        if (kDebugMode) {
          print(jsonRespose);
        }
        getsAllEmployees();
        notifyListeners();

        Fluttertoast.showToast(msg: "Emp agreement delete Successfully");
      }
    } on RemoteException catch (e) {
      Fluttertoast.showToast(msg: e.dioException.toString());
    }
  }
}
