import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ebn_el_hytham/core/services/supabase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'image_processing_state.dart';

class ImageProcessingCubit extends Cubit<ImageProcessingState> {
  ImageProcessingCubit() : super(ImageProcessingInitial());
  ImagePicker imagePicker = ImagePicker();
  File? pickedImage;
  Future<File?> getImage() async {
    log('Maths');
    XFile? imageXFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageXFile != null) {
      pickedImage = File(imageXFile!.path);
    }
    return pickedImage;
  }

  String? iamgeUrl;
  Future<void> imageToUrl() async {
    try {
      emit(ImageProcessingLoading());
      DateTime dateTime = DateTime.now();
      String path = basename(pickedImage!.path);
      await SupabaseService.supabase.storage
          .from('attendance_holder')
          .upload('${dateTime}_$path', pickedImage!);
      final String url = SupabaseService.supabase.storage
          .from('attendance_holder')
          .getPublicUrl('${dateTime}_$path');
      iamgeUrl = url;
      emit(ImageProcessingSuccess());
    } on Exception catch (e) {
      emit(ImageProcessingError(message: e.toString()));
    }
  }
}
