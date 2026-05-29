class ProfileModel {
  final String email;
  final String name;
  final String department;
  final String id;
  final String cgpa;
  final String level;
  final String dateOfBirth;
  final String acceptanceDate;
  final String address;
  final String gender;
  final String nationality;
  final String phone;
  final String photo;
  final String nationalId;
  final bool passwordChanged;

  ProfileModel({
    required this.email,
    required this.name,
    required this.department,
    required this.id,
    required this.cgpa,
    required this.level,
    required this.dateOfBirth,
    required this.acceptanceDate,
    required this.address,
    required this.gender,
    required this.nationality,
    required this.phone,
    required this.photo,
    required this.nationalId,
    required this.passwordChanged,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final personal = json['Personal_Information'] as Map<String, dynamic>;
    final academic = json['Academic_Information'] as Map<String, dynamic>;

    return ProfileModel(
      email: personal['email'] ?? '',
      name: personal['name'] ?? '',
      department: personal['department'] ?? '',
      id: personal['ID'].toString(),
      cgpa: academic['CGPA'].toString(),
      level: personal['level'].toString(),
      dateOfBirth: personal['date_of_birth'] ?? '',
      acceptanceDate: personal['joining_date'] ?? '',
      address: personal['address'] ?? '',
      gender: personal['gender'] ?? '',
      nationality: personal['nationality'] ?? '',
      phone: personal['phone'] ?? '',
      photo:
          'https://digitalhealthskills.com/wp-content/uploads/2022/11/3da39-no-user-image-icon-27.png',
      nationalId: personal['national_id'].toString(),
      passwordChanged: personal['password_changed'] ?? false,
    );
  }
}
