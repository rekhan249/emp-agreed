import 'package:emp_agreement/providers/admin_user_controller.dart';
import 'package:emp_agreement/providers/create_control.dart';
import 'package:emp_agreement/providers/date_controller.dart';
import 'package:emp_agreement/providers/gets_getsall_emps.dart';
import 'package:emp_agreement/providers/update_controller.dart';
import 'package:emp_agreement/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => DateProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CreateContollerProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UpdateContollerProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AdminUserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GetAllEmployees(),
          ),
        ],
        child: MaterialApp(
          title: 'Emp Agreement',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
            useMaterial3: true,
          ),
          initialRoute: RouteGenerator.transcreen,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
