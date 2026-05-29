import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/features/instructor/data/models/instructor_model.dart';
import 'package:meta/meta.dart';

part 'instructor_profile_state.dart';

class InstructorProfileCubit extends Cubit<InstructorProfileState> {
  InstructorProfileCubit() : super(InstructorProfileInitial());
  Future<void> getProfileData({required String token}) async {
    try {
      emit(InstructorProfileLoading());
      final response = await Dio().get(
        'https://markmarei-proapi.hf.space/teacher/$token',
      );
      log(response.toString());
      InstructorModel profileModel = InstructorModel.fromJson(response.data);

      emit(InstructorProfileSuccess(profile: profileModel!));
    } on Exception catch (e) {
      emit(InstructorProfileError(message: e.toString()));
    }
  }
}
