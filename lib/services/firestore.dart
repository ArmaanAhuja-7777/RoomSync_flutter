import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_automation/services/auth.dart';
import 'package:room_automation/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserProfile> getUserProfile() async {
    var userId = AuthService().user?.uid;
    if (userId == null) return UserProfile();

    var ref = _db.collection('user_profiles').doc(userId);
    var snapshot = await ref.get();
    return UserProfile.fromJson(snapshot.data() ?? {});
  }

  Future<void> updateUserReport(UserProfile profile) {
    var user = AuthService().user!;
    var ref = _db.collection('user_profiles').doc(user.uid);
    var data = profile.toJson();
    return ref.set(data, SetOptions(merge: true));
  }

  // Stream<Report> streamReport() {
  //   return AuthService().userStream.switchMap((user) {
  //     if (user != null) {
  //       var ref = _db.collection('reports').doc(user.uid);
  //       return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
  //     } else {
  //       return Stream.fromIterable([Report()]);
  //     }
  //   });
  // }
}
