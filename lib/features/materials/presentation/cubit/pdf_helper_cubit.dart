import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
part 'pdf_helper_state.dart';

class PdfHelperCubit extends Cubit<PdfHelperState> {
  PdfHelperCubit() : super(PdfHelperInitial());

  Future<void> generateMaterialGradesReport(
    InstructorMaterialModel material,
  ) async {
    try {
      emit(PdfHelperLoading());
      final pdf = pw.Document();

      // ── Fonts ──────────────────────────────────────────────────────────────
      final fontRegular = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Cairo-Regular.ttf'),
      );

      // ── Logo ───────────────────────────────────────────────────────────────
      final Uint8List logoBytes = (await rootBundle.load(
        'assets/alexandria-university_logo.jpg',
      )).buffer.asUint8List();
      final logo = pw.MemoryImage(logoBytes);

      // ── Meta ───────────────────────────────────────────────────────────────
      final String issueDate = DateFormat(
        'dd / MM / yyyy',
      ).format(DateTime.now());
      final String reportId = "RPT-${DateTime.now().millisecondsSinceEpoch}";
      final students = material.assignedMaterials;

      // ── Stats ──────────────────────────────────────────────────────────────
      final int total = students.length;
      final int passed = students.where((s) => s.total >= 50).length;
      final int failed = total - passed;
      final double average = total == 0
          ? 0
          : students.map((s) => s.total).reduce((a, b) => a + b) / total;
      final int highest = total == 0
          ? 0
          : students.map((s) => s.total).reduce((a, b) => a > b ? a : b);
      final int lowest = total == 0
          ? 0
          : students.map((s) => s.total).reduce((a, b) => a < b ? a : b);

      // ── Colors ─────────────────────────────────────────────────────────────
      const headerBg = PdfColor.fromInt(0xFF1A1F2E); // dark navy
      const accentGold = PdfColor.fromInt(0xFFFFC107); // amber
      const rowEven = PdfColor.fromInt(0xFFF5F5F5);
      const rowOdd = PdfColors.white;
      const passGreen = PdfColor.fromInt(0xFF2E7D32);
      const failRed = PdfColor.fromInt(0xFFC62828);
      const borderGrey = PdfColor.fromInt(0xFFBDBDBD);

      // ── Grade Letter helper ────────────────────────────────────────────────
      String gradeLetter(int total) {
        if (total >= 90) return 'A+';
        if (total >= 85) return 'A';
        if (total >= 80) return 'B+';
        if (total >= 75) return 'B';
        if (total >= 70) return 'C+';
        if (total >= 65) return 'C';
        if (total >= 60) return 'D+';
        if (total >= 50) return 'D';
        return 'F';
      }

      // ══════════════════════════════════════════════════════════════════════
      // PAGE BUILDER
      // ══════════════════════════════════════════════════════════════════════
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          // RTL text direction
          textDirection: pw.TextDirection.rtl,
          // ── Page header (repeats on every page) ────────────────────────
          header: (context) => pw.Column(
            children: [
              // Top strip
              pw.Container(
                color: headerBg,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logo, width: 50, height: 50),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          "جامعة الإسكندرية – كلية الهندسة",
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 14,
                            color: PdfColors.white,
                          ),
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          "تقرير درجات المادة",
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 11,
                            color: accentGold,
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "رقم التقرير: $reportId",
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 8,
                            color: PdfColors.grey300,
                          ),
                        ),
                        pw.Text(
                          "تاريخ الإصدار: $issueDate",
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 8,
                            color: PdfColors.grey300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Gold accent line
              pw.Container(height: 3, color: accentGold),
              pw.SizedBox(height: 12),
            ],
          ),
          // ── Page footer ────────────────────────────────────────────────
          footer: (context) => pw.Column(
            children: [
              pw.Container(height: 1, color: borderGrey),
              pw.SizedBox(height: 6),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "هذا التقرير سري ومخصص للاستخدام الأكاديمي فقط",
                    style: pw.TextStyle(
                      font: fontRegular,
                      fontSize: 8,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.Text(
                    "صفحة ${context.pageNumber} من ${context.pagesCount}",
                    style: pw.TextStyle(
                      font: fontRegular,
                      fontSize: 8,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          build: (context) => [
            // ── Course Info Card ──────────────────────────────────────────
            pw.Container(
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: borderGrey),
                borderRadius: pw.BorderRadius.circular(8),
                color: const PdfColor.fromInt(0xFFFAFAFA),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Text(
                    material.name,
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      font: fontRegular,
                      fontSize: 16,
                      color: headerBg,
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _infoCell(fontRegular, 'القسم', material.departmentName),
                      _infoCell(fontRegular, 'الكود', material.code),
                      _infoCell(fontRegular, 'الفرقة', material.level),
                      _infoCell(fontRegular, 'القاعة', material.location),
                      _infoCell(fontRegular, 'اليوم', material.day),
                      _infoCell(fontRegular, 'الوقت', material.time),
                    ],
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 14),

            // ── Stats Summary Row ─────────────────────────────────────────
            pw.Row(
              children: [
                _statCard(
                  fontRegular,
                  fontRegular,
                  'إجمالي الطلاب',
                  '$total',
                  headerBg,
                  PdfColors.white,
                ),
                pw.SizedBox(width: 8),
                _statCard(
                  fontRegular,
                  fontRegular,
                  'الناجحون',
                  '$passed',
                  passGreen,
                  PdfColors.white,
                ),
                pw.SizedBox(width: 8),
                _statCard(
                  fontRegular,
                  fontRegular,
                  'الراسبون',
                  '$failed',
                  failRed,
                  PdfColors.white,
                ),
                pw.SizedBox(width: 8),
                _statCard(
                  fontRegular,
                  fontRegular,
                  'المتوسط',
                  average.toStringAsFixed(1),
                  accentGold,
                  headerBg,
                ),
                pw.SizedBox(width: 8),
                _statCard(
                  fontRegular,
                  fontRegular,
                  'الأعلى',
                  '$highest',
                  passGreen,
                  PdfColors.white,
                ),
                pw.SizedBox(width: 8),
                _statCard(
                  fontRegular,
                  fontRegular,
                  'الأدنى',
                  '$lowest',
                  failRed,
                  PdfColors.white,
                ),
              ],
            ),

            pw.SizedBox(height: 16),

            // ── Section Title ─────────────────────────────────────────────
            pw.Row(
              children: [
                pw.Container(width: 4, height: 16, color: accentGold),
                pw.SizedBox(width: 8),
                pw.Text(
                  "كشف الدرجات التفصيلي",
                  style: pw.TextStyle(
                    font: fontRegular,
                    fontSize: 13,
                    color: headerBg,
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 8),

            // ── Grades Table ──────────────────────────────────────────────
            pw.Table(
              border: pw.TableBorder.all(color: borderGrey, width: 0.5),
              columnWidths: {
                0: const pw.FlexColumnWidth(0.7), // #
                1: const pw.FlexColumnWidth(2.5), // Name
                2: const pw.FlexColumnWidth(1.5), // ID
                3: const pw.FlexColumnWidth(1.2), // YearWork
                4: const pw.FlexColumnWidth(1.2), // Final
                5: const pw.FlexColumnWidth(1.2), // Total
                6: const pw.FlexColumnWidth(1.0), // Grade
                7: const pw.FlexColumnWidth(1.0), // Status
              },
              children: [
                // Header row
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: headerBg),
                  children:
                      [
                            '#',
                            'اسم الطالب',
                            'الرقم الجامعي',
                            'أعمال السنة',
                            'الامتحان النهائي',
                            'المجموع',
                            'التقدير',
                            'الحالة',
                          ]
                          .map(
                            (h) => pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 4,
                              ),
                              child: pw.Text(
                                h,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  font: fontRegular,
                                  fontSize: 9,
                                  color: PdfColors.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                // Data rows
                ...students.asMap().entries.map((entry) {
                  final i = entry.key;
                  final s = entry.value;
                  final isPassed = s.total >= 50;
                  final bg = i.isEven ? rowEven : rowOdd;
                  return pw.TableRow(
                    decoration: pw.BoxDecoration(color: bg),
                    children:
                        [
                              '${i + 1}',
                              s.name,
                              s.id,
                              '${s.yearWork}',
                              '${s.finalDegree}',
                              '${s.total}',
                              gradeLetter(s.total),
                              isPassed ? 'ناجح' : 'راسب',
                            ]
                            .asMap()
                            .entries
                            .map(
                              (cell) => pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 4,
                                ),
                                child: pw.Text(
                                  cell.value,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(
                                    font: cell.key == 7
                                        ? fontRegular
                                        : fontRegular,
                                    fontSize: 9,
                                    color: cell.key == 7
                                        ? (isPassed ? passGreen : failRed)
                                        : PdfColors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  );
                }),
              ],
            ),

            pw.SizedBox(height: 20),

            // ── Grade Distribution Summary ────────────────────────────────
            pw.Row(
              children: [
                pw.Container(width: 4, height: 16, color: accentGold),
                pw.SizedBox(width: 8),
                pw.Text(
                  "توزيع التقديرات",
                  style: pw.TextStyle(
                    font: fontRegular,
                    fontSize: 13,
                    color: headerBg,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: ['A+', 'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'F'].map((
                g,
              ) {
                final count = students
                    .where((s) => gradeLetter(s.total) == g)
                    .length;
                final pct = total == 0 ? 0.0 : (count / total) * 100;
                return _gradeDistCell(fontRegular, fontRegular, g, count, pct);
              }).toList(),
            ),

            pw.SizedBox(height: 20),

            // ── Signature block ───────────────────────────────────────────
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "اعتماد رئيس القسم",
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
                    ),
                    pw.SizedBox(height: 28),
                    pw.Text(
                      "___________________________",
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      "توقيع الدكتور / المحاضر",
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
                    ),
                    pw.SizedBox(height: 28),
                    pw.Text(
                      "___________________________",
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      "ختم الكلية",
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
                    ),
                    pw.SizedBox(height: 28),
                    pw.Text(
                      "___________________________",
                      style: pw.TextStyle(font: fontRegular, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      // ── Save & Open (Android-compatible) ──────────────────────────────────
      final bytes = await pdf.save();
      final dir =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
      final safeName = material.name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      final file = File('${dir.path}/تقرير_$safeName.pdf');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
      emit(PdfHelperSuccess());
    } on Exception catch (e) {
      log('PDF Error: $e');
      emit(PdfHelperFailure(e.toString()));
    }
  }

  // ── PDF Widget helpers ─────────────────────────────────────────────────────

  pw.Widget _infoCell(pw.Font font, String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            font: font,
            fontSize: 8,
            color: PdfColors.grey600,
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: font,
            fontSize: 9,
            color: const PdfColor.fromInt(0xFF1A1F2E),
          ),
        ),
      ],
    );
  }

  pw.Widget _statCard(
    pw.Font fontBold,
    pw.Font fontRegular,
    String label,
    String value,
    PdfColor bg,
    PdfColor textColor,
  ) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: pw.BoxDecoration(
          color: bg,
          borderRadius: pw.BorderRadius.circular(6),
        ),
        child: pw.Column(
          children: [
            pw.Text(
              value,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 14,
                color: textColor,
              ),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              label,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: fontRegular,
                fontSize: 7,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _gradeDistCell(
    pw.Font fontBold,
    pw.Font fontRegular,
    String grade,
    int count,
    double pct,
  ) {
    const headerBg = PdfColor.fromInt(0xFF1A1F2E);
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: const PdfColor.fromInt(0xFFBDBDBD),
          width: 0.5,
        ),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            grade,
            style: pw.TextStyle(font: fontBold, fontSize: 11, color: headerBg),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            '$count',
            style: pw.TextStyle(
              font: fontBold,
              fontSize: 12,
              color: const PdfColor.fromInt(0xFFFFC107),
            ),
          ),
          pw.Text(
            '${pct.toStringAsFixed(0)}%',
            style: pw.TextStyle(
              font: fontRegular,
              fontSize: 8,
              color: PdfColors.grey600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> doReceipt({
    required String totalAmount,
    required String paidAmount,
    required String date,
    required String transactionId,
    required String method,
    required String studentName,
    required String email,
    required String phone,
    required String nationalId,
    required String id,
  }) async {
    try {
      emit(PdfHelperLoading());
      final pdf = pw.Document();

      // ── Fonts ──────────────────────────────────────────────────────────────
      final fontRegular = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Cairo-Regular.ttf'),
      );

      // ── Logo ───────────────────────────────────────────────────────────────
      final Uint8List logoBytes = (await rootBundle.load(
        'assets/alexandria-university_logo.jpg',
      )).buffer.asUint8List();
      final logo = pw.MemoryImage(logoBytes);

      // ── Meta ───────────────────────────────────────────────────────────────
      final String issueDate = DateFormat(
        'dd / MM / yyyy',
      ).format(DateTime.now());
      final String receiptId = "REC-${DateTime.now().millisecondsSinceEpoch}";

      // ── Colors (B&W only) ──────────────────────────────────────────────────
      const darkColor = PdfColor.fromInt(0xFF1A1A1A);
      const greyLight = PdfColor.fromInt(0xFFF5F5F5);
      const greyMid = PdfColor.fromInt(0xFFBDBDBD);
      const greyText = PdfColor.fromInt(0xFF757575);

      // ── Row builder helper ─────────────────────────────────────────────────
      pw.Widget _receiptRow(
        pw.Font font,
        String label,
        String value, {
        bool isLast = false,
        bool isBold = false,
      }) {
        return pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: isLast
                  ? pw.BorderSide.none
                  : pw.BorderSide(color: greyMid, width: 0.5),
            ),
          ),
          padding: const pw.EdgeInsets.symmetric(vertical: 9, horizontal: 12),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                value,
                style: pw.TextStyle(
                  font: font,
                  fontSize: isBold ? 12 : 10,
                  color: darkColor,
                ),
              ),
              pw.Text(
                label,
                style: pw.TextStyle(
                  font: font,
                  fontSize: 10,
                  color: isBold ? darkColor : greyText,
                ),
              ),
            ],
          ),
        );
      }

      // ══════════════════════════════════════════════════════════════════════
      // PAGE
      // ══════════════════════════════════════════════════════════════════════
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          textDirection: pw.TextDirection.rtl,
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // ── Header ───────────────────────────────────────────────────
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Receipt meta
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "رقم الإيصال",
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 8,
                          color: greyText,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        receiptId,
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 9,
                          color: darkColor,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        "تاريخ الإصدار",
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 8,
                          color: greyText,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        issueDate,
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 9,
                          color: darkColor,
                        ),
                      ),
                    ],
                  ),
                  // Logo + title
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(logo, width: 56, height: 56),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        "جامعة الإسكندرية – كلية الهندسة",
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 12,
                          color: darkColor,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        "إيصال سداد المصاريف الدراسية",
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 10,
                          color: greyText,
                        ),
                      ),
                    ],
                  ),
                  // Spacer to balance layout
                  pw.SizedBox(width: 80),
                ],
              ),

              pw.SizedBox(height: 20),
              // Full-width divider
              pw.Container(height: 1.5, color: darkColor),
              pw.SizedBox(height: 20),

              // ── Student Info Section ──────────────────────────────────────
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: greyLight,
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(color: greyMid, width: 0.5),
                ),
                child: pw.Column(
                  children: [
                    // Section title
                    pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 12,
                      ),
                      decoration: pw.BoxDecoration(
                        color: const PdfColor.fromInt(0xFFE0E0E0),
                        borderRadius: const pw.BorderRadius.only(
                          topLeft: pw.Radius.circular(6),
                          topRight: pw.Radius.circular(6),
                        ),
                      ),
                      child: pw.Text(
                        "بيانات الطالب",
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 11,
                          color: darkColor,
                        ),
                      ),
                    ),
                    _receiptRow(fontRegular, "الاسم", studentName),
                    _receiptRow(fontRegular, "الرقم الجامعي", id),
                    _receiptRow(fontRegular, "الرقم القومي", nationalId),
                    _receiptRow(fontRegular, "البريد الإلكتروني", email),
                    _receiptRow(fontRegular, "رقم الهاتف", phone, isLast: true),
                  ],
                ),
              ),

              pw.SizedBox(height: 16),

              // ── Payment Info Section ──────────────────────────────────────
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: greyLight,
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(color: greyMid, width: 0.5),
                ),
                child: pw.Column(
                  children: [
                    pw.Container(
                      width: double.infinity,
                      padding: const pw.EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 12,
                      ),
                      decoration: pw.BoxDecoration(
                        color: const PdfColor.fromInt(0xFFE0E0E0),
                        borderRadius: const pw.BorderRadius.only(
                          topLeft: pw.Radius.circular(6),
                          topRight: pw.Radius.circular(6),
                        ),
                      ),
                      child: pw.Text(
                        "تفاصيل الدفع",
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 11,
                          color: darkColor,
                        ),
                      ),
                    ),
                    _receiptRow(fontRegular, "رقم العملية", transactionId),
                    _receiptRow(fontRegular, "طريقة الدفع", method),
                    _receiptRow(fontRegular, "تاريخ الدفع", date),
                    _receiptRow(
                      fontRegular,
                      "إجمالي المبلغ",
                      "$totalAmount جنيه",
                    ),
                    _receiptRow(
                      fontRegular,
                      "المبلغ المسدد",
                      "$paidAmount جنيه",
                      isLast: true,
                      isBold: true,
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // ── Confirmation stamp area ───────────────────────────────────
              pw.Container(
                padding: const pw.EdgeInsets.all(14),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: greyMid, width: 0.5),
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          "ختم إدارة الشؤون المالية",
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 10,
                            color: greyText,
                          ),
                        ),
                        pw.SizedBox(height: 32),
                        pw.Container(width: 120, height: 0.5, color: darkColor),
                      ],
                    ),
                    // Confirmed badge (text-only, no color)
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: darkColor, width: 1.5),
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Text(
                        "تم السداد",
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 16,
                          color: darkColor,
                        ),
                      ),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          "توقيع أمين الصندوق",
                          style: pw.TextStyle(
                            font: fontRegular,
                            fontSize: 10,
                            color: greyText,
                          ),
                        ),
                        pw.SizedBox(height: 32),
                        pw.Container(width: 120, height: 0.5, color: darkColor),
                      ],
                    ),
                  ],
                ),
              ),

              pw.Spacer(),

              // ── Footer ────────────────────────────────────────────────────
              pw.Container(height: 0.5, color: greyMid),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    receiptId,
                    style: pw.TextStyle(
                      font: fontRegular,
                      fontSize: 8,
                      color: greyText,
                    ),
                  ),
                  pw.Text(
                    "هذا الإيصال وثيقة رسمية – يُرجى الاحتفاظ به",
                    style: pw.TextStyle(
                      font: fontRegular,
                      fontSize: 8,
                      color: greyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      // ── Save & Open ────────────────────────────────────────────────────────
      final bytes = await pdf.save();
      final dir =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/إيصال_$receiptId.pdf');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
      emit(PdfHelperSuccess());
    } on Exception catch (e) {
      log('Receipt PDF Error: $e');
      emit(PdfHelperFailure(e.toString()));
    }
  }
}
