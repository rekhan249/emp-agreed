import 'package:emp_agreement/providers/create_control.dart';
import 'package:emp_agreement/providers/date_controller.dart';
import 'package:emp_agreement/utils/constants.dart';
import 'package:emp_agreement/widgets/customdate_form.dart';
import 'package:emp_agreement/widgets/customname_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateEmpScreen extends StatelessWidget {
  CreateEmpScreen({super.key});
  final _createEmpFormKey = GlobalKey<FormState>();
  final _empNameControl = TextEditingController();
  final _roleController = TextEditingController();
  final _startDateControl = TextEditingController();
  final _endDateControl = TextEditingController();
  final _salaryControl = TextEditingController();
  final _termsControl = TextEditingController();
  final _departmentControl = TextEditingController();
  final _managerControl = TextEditingController();

  void _submissionAgreementForm(BuildContext context) async {
    bool isValid = _createEmpFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _createEmpFormKey.currentState!.save();
    Provider.of<CreateContollerProvider>(context, listen: false)
        .submittedAgreement(
      context,
      _empNameControl,
      _roleController,
      _startDateControl,
      _endDateControl,
      _salaryControl,
      _termsControl,
      _departmentControl,
      _managerControl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _createEmpFormKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    kPageItemSpacing2,
                    Text(
                      'Create Emp Agreement',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _empNameControl,
                        icons: Icons.person_2_outlined,
                        hintText: 'full name'),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _roleController,
                        icons: Icons.supervised_user_circle,
                        hintText: 'role'),
                    kPageItemSpacing2,
                    Consumer<DateProvider>(
                      builder: (context, datePro, child) => CustomDateFormfield(
                        startDateControl: _startDateControl,
                        datePro: datePro,
                        hintText: 'Select start date',
                      ),
                    ),
                    kPageItemSpacing2,
                    Consumer<DateProvider>(
                      builder: (context, datePro, child) => CustomDateFormfield(
                        startDateControl: _endDateControl,
                        datePro: datePro,
                        hintText: 'Select end date',
                      ),
                    ),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _salaryControl,
                        icons: Icons.numbers,
                        hintText: 'salary'),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _termsControl,
                        icons: Icons.timelapse,
                        hintText: 'term'),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _departmentControl,
                        icons: Icons.post_add_outlined,
                        hintText: 'department'),
                    kPageItemSpacing2,
                    CustomNameTextFormField(
                        empNameController: _managerControl,
                        icons: Icons.manage_accounts,
                        hintText: 'manager'),
                    kPageItemSpacing2,
                    SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(kLightTextColor)),
                        onPressed: () => _submissionAgreementForm(context),
                        child: const Text('Create',
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
