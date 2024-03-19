class  Users{
  final String email;
  final String password;

  const Users({
    required this.email,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'password': String password,
      } =>
        Users(
          email: email,
          password: password,
        ),
      _ => throw const FormatException('Informations incorrecte'),
    };
  }
}
