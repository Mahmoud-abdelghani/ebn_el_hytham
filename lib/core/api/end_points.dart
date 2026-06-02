class EndPoints {
  static const String baseUrl =
      'https://markmarei-proapi.hf.space/'; //https://markmarei-proapi.hf.space/courses/CE/2/CE 252 جرب تستخدم ديه هتدخل بس الليفيل والكورس كباراميتر فى الريكويست
  static const String login = 'auth/login';
  static const String fetchAcademic = 'view_academic/';
  static const String fetchAssignedMaterials = 'student_academic_last/';
  static const String studentProgress = 'student_progress/';
  static const String teacher = 'teacher/';
  static const String dashboard = 'instructor/dashboard/';
  static const String updateGrades = 'update_grades/';
}
/*{
    "year_work": 19.5
}

JSON
{
    "final_exam": 55
}


JSON
{
    "year_work": 18,
    "final_exam": 52
} */

class ApiKeys {
  static const String name = 'name';
  static const String id = 'ID';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String department = 'department';
  static const String email = 'email';
  static const String gender = 'gender';
  static const String joiningDate = 'joining_date';
  static const String level = 'level';
  static const String nationalId = 'national_id';
  static const String nationality = 'nationality';
  static const String phone = 'phone';
  static const String photo = 'photo';
  static const String data = 'Data';
  static const String sGPA = 'SGPA';
  static const String totalCreditHoursPerSemester =
      'Total_Credit_Hours_Per_Semester';
  static const String materials = 'materials';
  static const String courseCode = 'course_code';
  static const String creditHours = 'credit_hours';
  static const String materialName = 'material_name';
  static const String result = 'result';
  static const String courseName = 'course_name';
  static const String prerequisites = 'prerequisites';
}
