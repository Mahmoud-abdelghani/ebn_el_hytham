part of 'voice_helper_cubit.dart';

@immutable
sealed class VoiceHelperState {}

final class VoiceHelperInitial extends VoiceHelperState {}

final class VoiceHelperOn extends VoiceHelperState {}

final class VoiceHelperStop extends VoiceHelperState {}
