class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String address;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

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
