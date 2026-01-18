class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String address;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'address': address};
  }

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
