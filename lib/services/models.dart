import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class UserProfile {
  String name;
  String detail;
  bool isFaculty;
  UserProfile({this.name = '', this.detail = '', this.isFaculty = false});
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
