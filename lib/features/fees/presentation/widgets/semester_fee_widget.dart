import 'dart:developer';

import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_button.dart';
import 'package:ebn_el_hytham/features/fees/data/models/student_fees_model.dart';
import 'package:ebn_el_hytham/features/fees/presentation/cubit/payment_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/pdf_helper_cubit.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:ebn_el_hytham/features/students/data/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/paymob.dart';

/// Expandable semester fee tile — themed card with accent accents.
class SemesterFeeWidget extends StatefulWidget {
  const SemesterFeeWidget({
    super.key,
    required this.index,
    required this.status,
    required this.totalAmount,
    required this.paid,
    required this.date,
    required this.method,
    required this.transactionId,
    required this.profile,
  });
  final int index;
  final String status;
  final String totalAmount;
  final String paid;
  final String date;
  final String method;
  final String transactionId;
  final ProfileModel profile;

  @override
  State<SemesterFeeWidget> createState() => _SemesterFeeWidgetState();
}

class _SemesterFeeWidgetState extends State<SemesterFeeWidget> {
  bool _isDownloading = false;
  @override
  Widget build(BuildContext context) {
    final bool isPaid = widget.status != 'Unpaid';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPaid ? context.accent.withOpacity(0.4) : context.cardBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: context.scaffold.withOpacity(0.6),
        collapsedBackgroundColor: Colors.transparent,
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          'Semester ${widget.index}',
          style: TextStyle(
            color: context.onBackground,
            fontSize: ScreenSize.height * 0.022,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isPaid
                ? context.accentSubtle
                : context.cs.error.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPaid
                  ? context.accentBorder
                  : context.cs.error.withOpacity(0.5),
            ),
          ),
          child: Text(
            widget.status,
            style: TextStyle(
              color: isPaid ? context.accent : context.cs.error,
              fontSize: ScreenSize.height * 0.015,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.04,
              vertical: ScreenSize.height * 0.01,
            ),
            child: Column(
              children: [
                StudentProfileStringsHelper(
                  firstTxt: 'Total Amount:',
                  secondTxt: widget.totalAmount,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Paid:',
                  secondTxt: widget.paid,
                ),
                SizedBox(height: ScreenSize.height * 0.01),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Details:',
                    style: TextStyle(
                      color: context.onSurfaceMuted,
                      fontSize: ScreenSize.height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Date:',
                  secondTxt: widget.date.isEmpty ? "Not Paid" : widget.date,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Method:',
                  secondTxt: widget.method.isEmpty ? "Not Paid" : widget.method,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Transaction ID:',
                  secondTxt: widget.transactionId,
                ),
                SizedBox(height: ScreenSize.height * 0.015),
                isPaid
                    ? BlocConsumer<PdfHelperCubit, PdfHelperState>(
                        listener: (context, state) {
                          if (state is PdfHelperSuccess ||
                              state is PdfHelperFailure) {
                            setState(() => _isDownloading = false);
                          }
                          if (state is PdfHelperFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            onTap: _isDownloading
                                ? () {}
                                : () {
                                    setState(() => _isDownloading = true);
                                    BlocProvider.of<PdfHelperCubit>(
                                      context,
                                    ).doReceipt(
                                      totalAmount: widget.totalAmount,
                                      paidAmount: widget.paid,
                                      date: widget.date,
                                      transactionId: widget.transactionId,
                                      method: widget.method,
                                      studentName: widget.profile.name,
                                      email: widget.profile.email,
                                      phone: widget.profile.phone,
                                      nationalId: widget.profile.nationalId,
                                      id: widget.profile.id,
                                    );
                                  },
                            txt: _isDownloading
                                ? SizedBox(
                                    width: ScreenSize.height * 0.025,
                                    height: ScreenSize.height * 0.025,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: context.cs.onSecondary,
                                    ),
                                  )
                                : Text(
                                    "Download Receipt",
                                    style: TextStyle(
                                      color: context.cs.onSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenSize.height * 0.022,
                                    ),
                                  ),
                          );
                        },
                      )
                    : const SizedBox(),
                SizedBox(height: ScreenSize.height * 0.01),
                if (!isPaid)
                  BlocListener<PaymentCubit, PaymentState>(
                    listener: (context, state) async {
                      if (state is PaymentSuccess) {
                        PaymobPaymentResult result = await Paymob.pay(
                          publicKey:
                              'egy_pk_test_XeTAn4mkrR2FT7dNxBY7FklCqXoTfPNU',
                          clientSecret: state.clientSecret,
                          appName: "Universe",
                        );
                        if (result.isSuccessful) {
                          studentFees.currentAmount = "0";
                          studentFees.semesterFees[0].status = "Paid";
                          log(result.transactionDetails.toString());
                          studentFees.semesterFees[0].transactionId =
                              result.transactionDetails!['integration_id'];
                          studentFees.semesterFees[0].date =
                              result.transactionDetails!['created_at'];
                          studentFees.semesterFees[0].method = result
                              .transactionDetails!['source_data.sub_type'];
                          studentFees.semesterFees[0].paidAmount = "4000";
                        }
                        Navigator.pop(context);
                      } else if (state is PaymentError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    child: CustomButton(
                      onTap: () {
                        BlocProvider.of<PaymentCubit>(
                          context,
                        ).fetchClientSecretFromBackend(
                          amount: int.parse(widget.totalAmount),
                        );
                      },
                      txt: Text(
                        'Pay Now',
                        style: TextStyle(
                          color: context.cs.onSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSize.height * 0.022,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: ScreenSize.height * 0.015),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
