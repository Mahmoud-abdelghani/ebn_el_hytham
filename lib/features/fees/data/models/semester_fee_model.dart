class SemesterFeeModel {
  String status;
  String totalAmount;
  String paidAmount;
  String date;
  String method;
  String transactionId;

  SemesterFeeModel({
    required this.status,
    required this.totalAmount,
    required this.paidAmount,
    required this.date,
    required this.method,
    required this.transactionId,
  });
}
