class UserData {
  static final UserData instance = UserData._internal();
  UserData._internal();

  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String password = '';
  String gender = '';
  String image = '';
  String bio = '';
}
