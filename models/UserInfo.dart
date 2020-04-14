class UserInfo{
  final String age;
  final String height;
  final String weight;

  UserInfo(
      {
        this.age, this.height, this.weight
      });

  List<Object> get props => [age, height, weight];

  static UserInfo fromJson(dynamic json){
    return UserInfo(
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}
