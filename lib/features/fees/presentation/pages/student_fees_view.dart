import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/fees/data/models/student_fees_model.dart';
import 'package:ebn_el_hytham/features/fees/presentation/widgets/semester_fee_widget.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

class StudentFeesView extends StatefulWidget {
  const StudentFeesView({super.key});
  static const String routeName = 'StudentFeesView';

  @override
  State<StudentFeesView> createState() => _StudentFeesViewState();
}

class _StudentFeesViewState extends State<StudentFeesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        title: Text(
          'Fees',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ListTile(
              tileColor: Colors.white,
              minTileHeight: ScreenSize.height * 0.11,
              leading: Text(
                "Current fees:",
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.027,
                ),
              ),
              trailing: Text(
                '${studentFees.currentAmount} EGP',
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.027,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.01)),
          SliverList.separated(
            itemCount: studentFees.semesterFees.length,
            itemBuilder: (context, index) => SemesterFeeWidget(
              index: index + 1,
              status: studentFees.semesterFees[index].status,
              totalAmount: studentFees.semesterFees[index].totalAmount,
              paid: studentFees.semesterFees[index].paidAmount,
              date: studentFees.semesterFees[index].date,
              method: studentFees.semesterFees[index].method,
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.02),
          ),
        ],
      ),
    );
  }
}
