import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class UserProfile {
  String name;
  String detail;
  String room_no;
  String roll;
  bool isFaculty;
  UserProfile(
      {this.name = '',
      this.detail = '',
      this.isFaculty = false,
      this.roll = '',
      this.room_no = ''});
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
