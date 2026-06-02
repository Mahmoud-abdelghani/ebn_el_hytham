import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:excel/excel.dart';
import 'package:meta/meta.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

part 'excel_handler_state.dart';

class ExcelHandlerCubit extends Cubit<ExcelHandlerState> {
  ExcelHandlerCubit() : super(ExcelHandlerInitial());
  Future<void> generateMaterialGradesExcel(
    InstructorMaterialModel material,
  ) async {
    try {
      emit(ExcelHandlerLoading());
      final excel = Excel.createExcel();
      final String sheetName = material.name.length > 28
          ? material.name.substring(0, 28)
          : material.name;

      // Delete default sheet then create ours
      excel.delete('Sheet1');
      final Sheet sheet = excel[sheetName];

      final students = material.assignedMaterials;

      // ── Styles ──────────────────────────────────────────────────────────────

      // Dark header

      final headerFont = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        fontColorHex: ExcelColor.fromHexString('#FFFFFF'),
        backgroundColorHex: ExcelColor.fromHexString('#1A1F2E'),
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );

      // Gold subheader (course info row)
      final subHeaderStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        fontColorHex: ExcelColor.fromHexString('#1A1F2E'),
        backgroundColorHex: ExcelColor.fromHexString('#FFC107'),
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );

      // Label style (left column of info block)
      final labelStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        fontColorHex: ExcelColor.fromHexString('#1A1F2E'),
        backgroundColorHex: ExcelColor.fromHexString('#F5F5F5'),
        horizontalAlign: HorizontalAlign.Right,
      );

      final valueStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        fontColorHex: ExcelColor.fromHexString('#333333'),
        horizontalAlign: HorizontalAlign.Left,
      );

      final evenRowStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        backgroundColorHex: ExcelColor.fromHexString('#FAFAFA'),
        horizontalAlign: HorizontalAlign.Center,
      );

      final oddRowStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        backgroundColorHex: ExcelColor.fromHexString('#FFFFFF'),
        horizontalAlign: HorizontalAlign.Center,
      );

      final passStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        fontColorHex: ExcelColor.fromHexString('#2E7D32'),
        backgroundColorHex: ExcelColor.fromHexString('#E8F5E9'),
        horizontalAlign: HorizontalAlign.Center,
      );

      final failStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        fontColorHex: ExcelColor.fromHexString('#C62828'),
        backgroundColorHex: ExcelColor.fromHexString('#FFEBEE'),
        horizontalAlign: HorizontalAlign.Center,
      );

      final totalStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
      );

      // ── Helper to set cell value + style ──────────────────────────────────
      void setCell(int row, int col, dynamic value, CellStyle style) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row),
        );
        if (value is int) {
          cell.value = IntCellValue(value);
        } else if (value is double) {
          cell.value = DoubleCellValue(value);
        } else {
          cell.value = TextCellValue(value.toString());
        }
        cell.cellStyle = style;
      }

      // ── Row 1: Title ───────────────────────────────────────────────────────
      // Merge A1:H1
      sheet.merge(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
        CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0),
      );
      final titleCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      );
      titleCell.value = TextCellValue('كشف أعمال السنة – ${material.name}');
      titleCell.cellStyle = CellStyle(
        fontFamily: getFontFamily(FontFamily.Arial),
        bold: true,
        fontSize: 14,
        fontColorHex: ExcelColor.fromHexString('#FFFFFF'),
        backgroundColorHex: ExcelColor.fromHexString('#1A1F2E'),
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );
      sheet.setRowHeight(0, 28);

      // ── Rows 2–4: Course info block ────────────────────────────────────────
      final infoRows = [
        ['القسم', material.departmentName, 'الكود', material.code],
        ['الفرقة', material.level, 'القاعة', material.location],
        ['اليوم', material.day, 'الوقت', material.time],
      ];

      for (int i = 0; i < infoRows.length; i++) {
        final r = i + 1;
        setCell(r, 0, infoRows[i][0], labelStyle);
        setCell(r, 1, infoRows[i][1], valueStyle);
        setCell(r, 2, infoRows[i][2], labelStyle);
        setCell(r, 3, infoRows[i][3], valueStyle);
        sheet.setRowHeight(r, 20);
      }

      // ── Row 5: Stats ───────────────────────────────────────────────────────
      final int total = students.length;

      final double avgYearWork = total == 0
          ? 0
          : students.map((s) => s.yearWork).reduce((a, b) => a + b) / total;

      final statsRow = 4;
      final statsLabels = [
        'إجمالي الطلاب',
        '$total',
        'متوسط أعمال السنة',
        avgYearWork.toStringAsFixed(1),
      ];
      for (int i = 0; i < statsLabels.length; i++) {
        setCell(
          statsRow,
          i,
          statsLabels[i],
          i.isEven ? labelStyle : subHeaderStyle,
        );
      }
      sheet.setRowHeight(statsRow, 22);

      // ── Row 6: Empty spacer ────────────────────────────────────────────────
      sheet.setRowHeight(5, 10);

      // ── Row 7: Table header ────────────────────────────────────────────────
      final tableHeaderRow = 6;
      final headers = [
        '#',
        'اسم الطالب',
        'الرقم الجامعي',
        'البريد الإلكتروني',
        'أعمال السنة',
      ];
      for (int c = 0; c < headers.length; c++) {
        setCell(tableHeaderRow, c, headers[c], headerFont);
      }
      sheet.setRowHeight(tableHeaderRow, 22);

      // ── Data rows ──────────────────────────────────────────────────────────
      for (int i = 0; i < students.length; i++) {
        final s = students[i];
        final r = tableHeaderRow + 1 + i;
        final isPassed = s.total >= 50;
        final baseStyle = i.isEven ? evenRowStyle : oddRowStyle;

        setCell(r, 0, i + 1, baseStyle);
        setCell(r, 1, s.name, baseStyle);
        setCell(r, 2, s.id, baseStyle);
        setCell(r, 3, s.email, baseStyle);
        setCell(r, 4, s.yearWork, baseStyle);
        sheet.setRowHeight(r, 18);
      }

      // ── Column widths ──────────────────────────────────────────────────────
      sheet.setColumnWidth(0, 5);
      sheet.setColumnWidth(1, 28);
      sheet.setColumnWidth(2, 14);
      sheet.setColumnWidth(3, 30);
      sheet.setColumnWidth(4, 14);
      // ── Save (Android-compatible) ──────────────────────────────────────────
      final fileBytes = excel.save();

      if (fileBytes == null) return;

      final dir =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();
      final safeName = material.name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      final file = File('${dir.path}/اعمال_السنة_$safeName.xlsx');
      await file.writeAsBytes(fileBytes);
      await OpenFile.open(file.path);
      log('Done');

      emit(ExcelHandlerSuccess());
    } on Exception catch (e) {
      log('Excel Error: $e');
      emit(ExcelHandlerFailure(e.toString()));
    }
  }
}
