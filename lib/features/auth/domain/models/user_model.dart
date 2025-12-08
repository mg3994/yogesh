enum UserRole {
  client,
  contractor,
  supplier;

  String get name {
    switch (this) {
      case UserRole.client:
        return 'Client';
      case UserRole.contractor:
        return 'Contractor';
      case UserRole.supplier:
        return 'Supplier';
    }
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final List<UserRole> roles;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.roles = const [UserRole.client],
  });

  bool hasRole(UserRole role) => roles.contains(role);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map(
                (e) => UserRole.values.firstWhere(
                  (r) => r.name.toLowerCase() == e.toString().toLowerCase(),
                  orElse: () => UserRole.client,
                ),
              )
              .toList() ??
          [UserRole.client],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'roles': roles.map((e) => e.name.toLowerCase()).toList(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    List<UserRole>? roles,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      roles: roles ?? this.roles,
    );
  }
}


         
                
              