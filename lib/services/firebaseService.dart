import 'package:firebase_core/firebase_core.dart';

class LazyFirebaseService {
  FirebaseApp? firebaseApp;

  Future<FirebaseApp> initFirebaseApp() async {
    FirebaseApp _initialization = await Firebase.initializeApp();
    this.firebaseApp = _initialization;
    return _initialization;
  }
}
