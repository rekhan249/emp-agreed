class EmployeeInfoModel {
  EmployeeInfoModel({
    required this.employeeName,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.salary,
    required this.terms,
    required this.otherDetails,
  });

  final String? employeeName;
  final String? role;
  final String? startDate;
  final String? endDate;
  final String? salary;
  final String? terms;
  final OtherDetails? otherDetails;

  factory EmployeeInfoModel.fromJson(Map<String, dynamic> json) {
    return EmployeeInfoModel(
      employeeName: json["employeeName"],
      role: json["role"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      salary: json["salary"],
      terms: json["terms"],
      otherDetails: json["otherDetails"] == null
          ? null
          : OtherDetails.fromJson(json["otherDetails"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "employeeName": employeeName,
        "role": role,
        "startDate": startDate,
        "endDate": endDate,
        "salary": salary,
        "terms": terms,
        "otherDetails": otherDetails?.toJson(),
      };
}

class OtherDetails {
  OtherDetails({
    required this.department,
    required this.manager,
  });

  final String? department;
  final String? manager;

  factory OtherDetails.fromJson(Map<String, dynamic> json) {
    return OtherDetails(
      department: json["department"],
      manager: json["manager"],
    );
  }

  Map<String, dynamic> toJson() => {
        "department": department,
        "manager": manager,
      };
}
