import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/fees/data/models/student_fees_model.dart';
import 'package:ebn_el_hytham/features/fees/presentation/widgets/semester_fee_widget.dart';
import 'package:ebn_el_hytham/features/students/data/models/profile_model.dart';
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
    ProfileModel profile = ModalRoute.of(context)!.settings.arguments as ProfileModel;
    return Scaffold(
      backgroundColor: context.scaffold,
      appBar: buildDarkAppBar(context, 'Fees'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.04,
                vertical: ScreenSize.height * 0.015,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.05,
                vertical: ScreenSize.height * 0.02,
              ),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: context.glassBorder, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: context.shadowColor,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current fees:",
                    style: TextStyle(
                      color: context.onSurfaceMuted,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenSize.height * 0.022,
                    ),
                  ),
                  Text(
                    '${studentFees.currentAmount} EGP',
                    style: TextStyle(
                      color: context.accent,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenSize.height * 0.022,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.01),
          ),
          SliverList.separated(
            itemCount: studentFees.semesterFees.length,
            itemBuilder: (context, index) => SemesterFeeWidget(
              index: index + 1,
              status: studentFees.semesterFees[index].status,
              totalAmount: studentFees.semesterFees[index].totalAmount,
              paid: studentFees.semesterFees[index].paidAmount,
              date: studentFees.semesterFees[index].date,
              method: studentFees.semesterFees[index].method, transactionId: studentFees.semesterFees[index].transactionId, profile: profile,
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.012),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.02),
          ),
        ],
      ),
    );
  }
}
