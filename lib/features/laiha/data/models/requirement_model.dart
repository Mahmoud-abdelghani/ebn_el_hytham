class RequirementModel {
  final String name;
  final String code;

  RequirementModel({
    required this.name,
    required this.code,
  });
   factory RequirementModel.fromJson(Map<String, dynamic> json) {
    return RequirementModel(
      name: json['course_name'] as String,
      code: json['course_code'] as String,
    );
  }
}