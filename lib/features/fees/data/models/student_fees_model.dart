import 'package:ebn_el_hytham/features/fees/data/models/semester_fee_model.dart';

class StudentFeesModel {
  final String currentAmount;
  final List<SemesterFeeModel> semesterFees;

  StudentFeesModel({required this.currentAmount, required this.semesterFees});
  
}
final StudentFeesModel studentFees = StudentFeesModel(
  currentAmount: "9000", // المتبقي على الطالب للسمستر الأخير
  semesterFees: [
    // ---------------- SEMESTER 1 (2022) ----------------
    SemesterFeeModel(
      status: "Paid",
      totalAmount: "8200",
      paidAmount: "8200",
      date: "2022-11-10",
      method: "University Treasury", // خزينة الكلية
    ),

    // ---------------- SEMESTER 2 (2023) ----------------
    SemesterFeeModel(
      status: "Paid",
      totalAmount: "8500",
      paidAmount: "8500",
      date: "2023-05-18",
      method: "Bank Deposit (CIB)", // إيداع بنكي CIB
    ),

    // ---------------- SEMESTER 3 (2023/2024) ----------------
    SemesterFeeModel(
      status: "Paid",
      totalAmount: "8800",
      paidAmount: "8800",
      date: "2023-12-22",
      method: "Visa Card", // ماكينة الفيزا في شئون الطلاب
    ),

    // ---------------- SEMESTER 4 (2024/2025) — UNPAID ----------------
    SemesterFeeModel(
      status: "Unpaid",
      totalAmount: "9000",
      paidAmount: "0",
      date: "",
      method: "", // لسه متدفعش
    ),
  ],
);
