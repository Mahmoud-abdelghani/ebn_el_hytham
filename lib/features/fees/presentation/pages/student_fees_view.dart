import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
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
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Fees'),
      body: CustomScrollView(
        slivers: [
          // ── Current fees banner ─────────────────────────────────
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
                // [surfaceColor] banner card
                color: ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
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
                      color: ColorGuid.textSecondary, // [textSecondary] label
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenSize.height * 0.022,
                    ),
                  ),
                  // [amber] value for the amount
                  Text(
                    '${studentFees.currentAmount} EGP',
                    style: TextStyle(
                      color: ColorGuid.amber,
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
          // ── Semester fee list ───────────────────────────────────
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
