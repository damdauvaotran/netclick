class UserInfo {
  UserInfo({this.userName = '', this.name = ''});

  String userName;
  String name;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userName: json['userName'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      userName: userName,
      name: name,
    };
  }
}
