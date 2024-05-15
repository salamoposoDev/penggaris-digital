import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penggaris_digital/cubit/get_user_cubit.dart';
import 'package:penggaris_digital/models/user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();

    // Ganti 'data' dengan nama node Anda di Firebase
  }

  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseDatabase.instance.ref();
    // ref.onValue.listen((event) {
    //   if (event.snapshot.exists) {
    //     final jsonString = jsonEncode(event.snapshot.value);
    //     // log(jsonString);
    //     Map<String, dynamic> data =
    //         Map<String, dynamic>.from(event.snapshot.value as Map);
    //     List<UserData> users = data.entries
    //         .map((entry) => UserData.fromJson(
    //             entry.key, Map<String, dynamic>.from(entry.value)))
    //         .toList();
    //   }
    // });
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            'Penggaris Digital',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.blue.shade300,
          elevation: 2,
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => GetUserCubit()..getData(),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<GetUserCubit, GetUserState>(
                  builder: (context, state) {
                    if (state is GetUserData) {
                      return GridView.builder(
                          itemCount: state.userData.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.userData[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Jarak = ${state.userData[index].sensorJarak}Cm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.userData[index].lampu1 == 1
                                            ? 'ON'
                                            : 'OFF',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      CupertinoSwitch(
                                        thumbColor: Colors.grey.shade200,
                                        trackColor: Colors.grey,
                                        activeColor: Colors.blue.shade800,
                                        value: state.userData[index].lampu1 == 1
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          int newVal = value ? 1 : 0;
                                          FirebaseDatabase.instance
                                              .ref(state.userData[index].name)
                                              .update({'lampu1': newVal});
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                    return Center(child: Text('Belum Ada Data'));
                  },
                )),
          ),
        ));
  }
}
