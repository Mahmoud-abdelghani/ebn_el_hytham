part of 'image_processing_cubit.dart';

@immutable
sealed class ImageProcessingState {}

final class ImageProcessingInitial extends ImageProcessingState {}

final class ImageProcessingLoading extends ImageProcessingState {}
final class ImageProcessingSuccess extends ImageProcessingState {}
final class ImageProcessingError extends ImageProcessingState {
  final String message;
  ImageProcessingError({required this.message});
}
