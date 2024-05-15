import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:penggaris_digital/models/user_data.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  final ref = FirebaseDatabase.instance.ref();

  void getData() {
    try {
      ref.onValue.listen((event) {
        if (event.snapshot.exists) {
          // final jsonString = jsonEncode(event.snapshot.value);
          Map<String, dynamic> data =
              Map<String, dynamic>.from(event.snapshot.value as Map);
          List<UserData> users = data.entries
              .map((entry) => UserData.fromJson(
                  entry.key, Map<String, dynamic>.from(entry.value)))
              .toList();
          emit(GetUserData(userData: users));
        } else {
          emit(GetUserEmpty());
        }
      });
    } catch (e) {
      emit(GetUserError(error: e.toString()));
    }
  }
}
