import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ebn_el_hytham/core/api/api_consumer.dart';
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/features/students/data/models/profile_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileModel? profileModel;

  Future<void> getProfileData({required String token}) async {
    try {
      emit(ProfileLoading());
      final response = await Dio().get(
        '${EndPoints.baseUrl}auth/my_profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log(response.toString());
      profileModel = ProfileModel.fromJson(response.data);

      emit(ProfileSuccess(profile: profileModel!));
    } on Exception catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
