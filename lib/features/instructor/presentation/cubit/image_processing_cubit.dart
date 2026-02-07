import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_processing_state.dart';

class ImageProcessingCubit extends Cubit<ImageProcessingState> {
  ImageProcessingCubit() : super(ImageProcessingInitial());
  ImagePicker imagePicker = ImagePicker();
  Future<File?> getImage() async {
    log('Maths');
    File? pickedImage;
    XFile? imageXFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageXFile != null) {
      pickedImage = File(imageXFile!.path);
    }
    return pickedImage;
  }
}
