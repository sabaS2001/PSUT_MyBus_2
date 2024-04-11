import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  //This method is for registering new student into our application and making each user our object in our firebase application
  static Future<User?> registerThroughEmail(
      {required String password, required String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password is weak");
      } else if (e.code == 'email-already-in-use') {
        print("The account already exist for that email");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
  //This method is for retrieving the User object and get any additional infomation of the object we want,

  static Future<User?> signInUsingEmail({
    required String password,
    required String email,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return user;
  }

  //Refreshing the user, if it's been a long time since they logged out or used the application
  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  //This method is for the user to change their own password
  static Future<User?> changePassword({
    required String currentPassword,
      required String newPassword,
      required String email
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Reauthenticate the user.
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user?.reauthenticateWithCredential(credential);

      // If reauthentication is successful, change the password.
      await user?.updatePassword(newPassword);

      // Password changed successfully.
      print('Password changed successfully.') ;
    }
    catch (e) {
      // Handle reauthentication errors and password change errors.
      print('Error changing password: $e') ;
    }
  }
}
