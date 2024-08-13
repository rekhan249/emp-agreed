import 'package:emp_agreement/models/get_emp_model.dart';
import 'package:emp_agreement/providers/date_controller.dart';
import 'package:emp_agreement/providers/gets_getsall_emps.dart';
import 'package:emp_agreement/providers/update_controller.dart';
import 'package:emp_agreement/utils/constants.dart';
import 'package:emp_agreement/widgets/customdate_form.dart';
import 'package:emp_agreement/widgets/customname_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateEmpScreen extends StatefulWidget {
  final int? id;
  final Employee? empData;
  const UpdateEmpScreen({super.key, this.id, this.empData});

  @override
  State<UpdateEmpScreen> createState() => _UpdateEmpScreenState();
}

class _UpdateEmpScreenState extends State<UpdateEmpScreen> {
  final _createEmpFormKey = GlobalKey<FormState>();
  final _empNameControl = TextEditingController();
  final _roleController = TextEditingController();
  final _startDateControl = TextEditingController();
  final _endDateControl = TextEditingController();
  final _salaryControl = TextEditingController();
  final _termsControl = TextEditingController();
  final _departmentControl = TextEditingController();
  final _managerControl = TextEditingController();
  GetAllEmployees getAllEmployees = GetAllEmployees();

  void _submissionUpdateAgreementForm(BuildContext context) async {
    bool isValid = _createEmpFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _createEmpFormKey.currentState!.save();
    Provider.of<UpdateContollerProvider>(context, listen: false)
        .submittedUpdatationAgreement(
      context,
      _empNameControl,
      _roleController,
      _startDateControl,
      _endDateControl,
      _salaryControl,
      _termsControl,
      _departmentControl,
      _managerControl,
      widget.id,
    );
  }

  @override
  void initState() {
    getInitialValue();
    super.initState();
  }

  getInitialValue() {
    _empNameControl.text = widget.empData!.employeeName.toString();
    _roleController.text = widget.empData!.role.toString();
    _startDateControl.text = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(widget.empData!.startDate.toString()));
    _endDateControl.text = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(widget.empData!.endDate.toString()));
    _salaryControl.text = widget.empData!.salary.toString();
    _termsControl.text = widget.empData!.terms.toString();
    for (int i = 0; i < widget.empData!.otherDetails.length; i++) {
      _departmentControl.text =
          widget.empData!.otherDetails[i].department.toString();
      _managerControl.text = widget.empData!.otherDetails[i].manager.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Update Emp Agreement',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _createEmpFormKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
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
                        onPressed: () =>
                            _submissionUpdateAgreementForm(context),
                        child: const Text('Update',
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
