import 'package:ebn_el_hytham/features/fees/data/models/semester_fee_model.dart';

class StudentFeesModel {
  String currentAmount;
  final List<SemesterFeeModel> semesterFees;

  StudentFeesModel({required this.currentAmount, required this.semesterFees});
}

final StudentFeesModel studentFees = StudentFeesModel(
  currentAmount: "4000", // المتبقي على الطالب للسمستر الأخير
  semesterFees: [
    // ---------------- SEMESTER 1 (2022) ----------------

    // ---------------- SEMESTER 4 (2024/2025) — UNPAID ----------------
    SemesterFeeModel(
      status: "Unpaid",
      totalAmount: "4000",
      paidAmount: "0",
      date: "",
      method: "",
      transactionId: 'Not Paid', // لسه متدفعش
    ),
  ],
);
