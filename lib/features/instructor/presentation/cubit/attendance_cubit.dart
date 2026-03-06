import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  Future<void> getAttendance({
    required String url,
    required String date,
    required String materialName,
  }) async {
    try {
      emit(AttendanceLoading());
      await Dio().post(
        'https://markmarei-modeltest.hf.space/submit',
        data: {'PhotoLink': url, "Date": date, "Subject": materialName},
      );
      log('Attendance');
      emit(AttendanceSuccess());
    } on Exception catch (e) {
      emit(AttendanceError(message: e.toString()));
    }
  }
}
