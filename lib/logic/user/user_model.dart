class UserModel {
  String id;
  bool isAdmin;
  String lastName;
  String firstName;
  String email;
  String avatar;
  String phone;
  String zipCode;
  String address;
  String city;
  // TODO: Make
  // UserCourse[]

  UserModel(
      {required this.id,
      required this.isAdmin,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.avatar,
      required this.phone,
      required this.zipCode,
      required this.address,
      required this.city});

  static UserModel fromJson(dynamic json) {
    return UserModel(
      id: json['id'],
      isAdmin: json['isAdmin'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'],
      avatar: json['avatar'],
      phone: json['phone'],
      zipCode: json['zipCode'],
      address: json['address'],
      city: json['city'],
    );
  }
}
