import 'package:emp_agreement/providers/admin_user_controller.dart';
import 'package:emp_agreement/utils/constants.dart';
import 'package:emp_agreement/widgets/customname_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminUserScreen extends StatelessWidget {
  AdminUserScreen({super.key});
  final _adminFormKey = GlobalKey<FormState>();
  final _emailControl = TextEditingController();
  final _passwordController = TextEditingController();

  void _submissionLoginForm(BuildContext context) async {
    bool isValid = _adminFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _adminFormKey.currentState!.save();
    Provider.of<AdminUserProvider>(context, listen: false).submittedLoginForm(
      context,
      _emailControl,
      _passwordController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _adminFormKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    kPageItemSpacing2,
                    Text(
                      'Admin Login',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _emailControl,
                        icons: Icons.person_2_outlined,
                        hintText: 'email'),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _passwordController,
                        icons: Icons.supervised_user_circle,
                        hintText: 'password'),
                    kPageItemSpacing2,
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(kLightTextColor)),
                        onPressed: () => _submissionLoginForm(context),
                        child: const Text('Admin Login',
                            style: TextStyle(color: kWhiteColor)),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
