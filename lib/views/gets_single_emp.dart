import 'package:emp_agreement/models/get_emp_model.dart';
import 'package:emp_agreement/providers/gets_getsall_emps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetSingleEmp extends StatelessWidget {
  final int? id;
  final Employee? emploayeeData;
  const GetSingleEmp({super.key, this.id, this.emploayeeData});

  @override
  Widget build(BuildContext context) {
    GetAllEmployees getAllEmployees = GetAllEmployees();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Employees Details"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              FutureBuilder<List<Employee>>(
                  future: getAllEmployees.getsEmployee(id: id),
                  builder: (context, AsyncSnapshot<List<Employee>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      List<Employee>? empData = snapshot.data;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: empData!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "id : ${empData[index].id}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Name : ${empData[index].employeeName}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Role : ${empData[index].role}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start Date : ${DateFormat("yyyy-MM-dd").format(DateTime.parse(empData[index].startDate.toString()))}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "End Date : ${DateFormat("yyyy-MM-dd").format(DateTime.parse(empData[index].endDate.toString()))}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Salary : ${empData[index].salary}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Term : ${empData[index].terms}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Other Details",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Department : ${empData[index].otherDetails[index].department}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        Text(
                                          "Manager :${empData[index].otherDetails[index].manager}",
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
