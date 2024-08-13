import 'package:emp_agreement/providers/gets_getsall_emps.dart';
import 'package:emp_agreement/utils/routes.dart';
import 'package:emp_agreement/views/gets_single_emp.dart';
import 'package:emp_agreement/views/update_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReadEmpScreen extends StatefulWidget {
  const ReadEmpScreen({super.key});

  @override
  State<ReadEmpScreen> createState() => _ReadEmpScreenState();
}

class _ReadEmpScreenState extends State<ReadEmpScreen> {
  @override
  void initState() {
    Provider.of<GetAllEmployees>(context, listen: false).getsAllEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GetAllEmployees>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Employees"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    suffixIcon: const Icon(Icons.search),
                    hintText: '  Search here',
                  ),
                  onChanged: (value) {
                    Provider.of<GetAllEmployees>(context, listen: false)
                        .searchInData(querySearch: value);
                  },
                ),
                SizedBox(height: 20.h),
                Consumer<GetAllEmployees>(
                  builder: (context, getAllEmpPro, child) => getAllEmpPro
                              .isloader ==
                          true
                      ? const CircularProgressIndicator()
                      : getAllEmpPro.employeeList.isEmpty
                          ? const Center(child: Text("No data yet"))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: getAllEmpPro.employeeList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  GetSingleEmp(
                                                      id: getAllEmpPro
                                                          .employeeList[index]
                                                          .recordId,
                                                      emploayeeData:
                                                          getAllEmpPro
                                                                  .employeeList[
                                                              index]),
                                            ));
                                      },
                                      child: Container(
                                        width: double.infinity.w,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: ListTile(
                                              title: Text(
                                                getAllEmpPro.employeeList[index]
                                                    .employeeName
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 15.sp),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 05.h),
                                                  Text(
                                                      getAllEmpPro
                                                          .employeeList[index]
                                                          .role
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12.sp)),
                                                  SizedBox(height: 15.h),
                                                  Text(
                                                    DateFormat("yyyy-MM-dd")
                                                        .format(DateTime.parse(
                                                            getAllEmpPro
                                                                .employeeList[
                                                                    index]
                                                                .startDate
                                                                .toString())),
                                                    style: TextStyle(
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                              trailing: Column(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => UpdateEmpScreen(
                                                                  id: getAllEmpPro
                                                                      .employeeList[
                                                                          index]
                                                                      .recordId,
                                                                  empData: getAllEmpPro
                                                                          .employeeList[
                                                                      index]),
                                                            ));
                                                      },
                                                      child: const Icon(
                                                          Icons.edit)),
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),
                                                  Consumer<GetAllEmployees>(
                                                    builder: (context, delPro,
                                                            child) =>
                                                        InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: const Text(
                                                                  "Are you want to sure to delete content?"),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    delPro.submittedDeletionAgreement(
                                                                        context,
                                                                        id: getAllEmpPro
                                                                            .employeeList[index]
                                                                            .recordId);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "Yes"),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "No"),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                          Icons.delete_forever),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: const Divider(
                                            color: Colors.black26)),
                                    SizedBox(height: 10.h),
                                  ],
                                );
                              },
                            ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.popAndPushNamed(context, RouteGenerator.createEmp);
            }),
      ),
    );
  }
}
