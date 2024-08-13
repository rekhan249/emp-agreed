class EmpGetsAll {
  EmpGetsAll({
    required this.data,
  });

  final List<Employee> data;

  factory EmpGetsAll.fromJson(Map<String, dynamic> json) {
    return EmpGetsAll(
      data: json["data"] == null
          ? []
          : List<Employee>.from(json["data"]!.map((x) => Employee.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Employee {
  Employee({
    required this.recordId,
    required this.id,
    required this.employeeName,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.salary,
    required this.terms,
    required this.otherDetails,
  });

  final int? recordId;
  final String? id;
  final String? employeeName;
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? salary;
  final String? terms;
  final List<OtherDetail> otherDetails;

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      recordId: json["record_id"],
      id: json["id"],
      employeeName: json["employeeName"],
      role: json["role"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      salary: json["salary"],
      terms: json["terms"],
      otherDetails: json["otherDetails"] == null
          ? []
          : List<OtherDetail>.from(
              json["otherDetails"]!.map((x) => OtherDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "record_id": recordId,
        "id": id,
        "employeeName": employeeName,
        "role": role,
        "startDate":
            "${startDate!.year.toString()}-${startDate!.month.toString()}-${startDate!.day.toString()}",
        "endDate": endDate?.toIso8601String(),
        "salary": salary,
        "terms": terms,
        "otherDetails": otherDetails.map((x) => x.toJson()).toList(),
      };
}

class OtherDetail {
  OtherDetail({
    required this.department,
    required this.manager,
  });

  final String? department;
  final String? manager;

  factory OtherDetail.fromJson(Map<String, dynamic> json) {
    return OtherDetail(
      department: json["department"],
      manager: json["manager"],
    );
  }

  Map<String, dynamic> toJson() => {
        "department": department,
        "manager": manager,
      };
}
