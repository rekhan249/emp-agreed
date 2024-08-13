import 'package:emp_agreement/errors/exceptions.dart';
import 'package:emp_agreement/views/admin_user.dart';
import 'package:emp_agreement/views/create_employee.dart';
import 'package:emp_agreement/views/get_all_employee.dart';
import 'package:emp_agreement/views/gets_single_emp.dart';
import 'package:emp_agreement/views/splash.dart';
import 'package:emp_agreement/views/transcation_page.dart';
import 'package:emp_agreement/views/update_employee.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splash = "/";
  static const String transcreen = "transcreen";
  static const String admin = "admin";
  static const String createEmp = "createEmp";
  static const String readEmp = "readEmp";
  static const String readEmpSingle = "readEmpSingle";
  static const String updateEmp = "updateEmp";
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case transcreen:
        return MaterialPageRoute(
          builder: (context) => const TransactionScreen(),
        );
      case admin:
        return MaterialPageRoute(
          builder: (context) => AdminUserScreen(),
        );
      case createEmp:
        return MaterialPageRoute(
          builder: (context) => CreateEmpScreen(),
        );
      case readEmp:
        return MaterialPageRoute(
          builder: (context) => const ReadEmpScreen(),
        );
      case readEmpSingle:
        return MaterialPageRoute(
          builder: (context) => const GetSingleEmp(),
        );
      case updateEmp:
        return MaterialPageRoute(
          builder: (context) => const UpdateEmpScreen(),
        );
      default:
        throw RouteException('Route not found');
    }
  }
}
