class UserData {
  String name;
  int lampu1;
  int sensorJarak;

  UserData({
    required this.name,
    required this.lampu1,
    required this.sensorJarak,
  });

  factory UserData.fromJson(String name, Map<String, dynamic> json) {
    return UserData(
      name: name,
      lampu1: json['lampu1'],
      sensorJarak: json['sensorJarak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lampu1': lampu1,
      'sensorJarak': sensorJarak,
    };
  }
}
