class RegisterUser {

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String password2;
  final String? gender;
  final String? imageUrl;
  final String? bio;

  RegisterUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.password2,
    required this.gender,
    required this.imageUrl,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "password2": password2,
      "gender": gender,
      "image_url": imageUrl,
      "bio": bio,
    };
  }
}
