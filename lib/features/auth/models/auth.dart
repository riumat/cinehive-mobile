class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class SignupRequest {
  final String email;
  final String password;
  final String username;

  SignupRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'username': username,
  };
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User? user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
    user: json['user'] != null ? User.fromJson(json['user']) : null,
  );
}

class User {
  final String id;
  final String email;
  final String? name;

  User({
    required this.id,
    required this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    name: json['name'],
  );
}