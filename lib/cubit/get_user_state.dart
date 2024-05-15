part of 'get_user_cubit.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}

final class GetUserError extends GetUserState {
  final String error;

  GetUserError({required this.error});
}

final class GetUserEmpty extends GetUserState {}

final class GetUserData extends GetUserState {
  final List<UserData> userData;

  GetUserData({required this.userData});
}
