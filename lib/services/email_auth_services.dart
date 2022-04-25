import '../constant.dart';

class FireBaseService {
  static Future<bool> signUpService({String? email, String? password}) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        )
        .catchError(
          (e) => print('error===>>$e'),
        );
    return true;
  }

  static Future<bool> logInService({String? email, String? password}) async {
    await firebaseAuth
        .signInWithEmailAndPassword(
          email: email!,
          password: password!,
        )
        .catchError(
          (e) => print(e),
        );
    return true;
  }

  static Future logOut() async {
    await firebaseAuth.signOut();
  }
}
