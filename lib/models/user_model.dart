class UserModel {
  final String? id; // Firebase document ID के लिए
  final String name;
  final String mobileNumber;

  UserModel({this.id, required this.name, required this.mobileNumber});

  // Firestore के लिए Map format
  Map<String, dynamic> toJson() {
    return {'name': name, 'mobileNumber': mobileNumber};
  }

  // Firestore से data लेने के लिए
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'],
      mobileNumber: json['mobileNumber'],
    );
  }
}
