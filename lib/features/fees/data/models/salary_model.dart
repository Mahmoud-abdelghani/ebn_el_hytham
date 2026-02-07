class SalaryModel {
  final String month;
  final String date;
  final double amount;
  SalaryModel({required this.month, required this.date, required this.amount}); 

}

List<SalaryModel> instructorSalaryData = [
  SalaryModel(month: 'January', date: '2024-01-31', amount: 1500.0),
  SalaryModel(month: 'February', date: '2024-02-29', amount: 1500.0),
  SalaryModel(month: 'March', date: '2024-03-31', amount: 1500.0),
  SalaryModel(month: 'April', date: '2024-04-30', amount: 1500.0),
  SalaryModel(month: 'May', date: '2024-05-31', amount: 1500.0),
  SalaryModel(month: 'June', date: '2024-06-30', amount: 1500.0),
];