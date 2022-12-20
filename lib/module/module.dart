class user{

  late final String uid;
  user({required this.uid});//we are using the Constructor to set the uid by named parameter
}
class UserData{
  late final String uid;
  late final String name;
  late final String Sugar;
  late final int Strength;
  UserData({
    required this.uid,
    required this.name,
    required this.Sugar,
    required this.Strength,

});
}