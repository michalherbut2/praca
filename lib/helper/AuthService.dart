import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:most_app/models/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Serwis do zarządzania uwierzytelnianiem użytkownika.
/// Obsługuje logowanie client-side przez Google i Facebook.
class AuthService with ChangeNotifier {
  AppUser? _user;
  String? _token; // <- tutaj trzymamy token w pamięci
  AppUser? get user => _user;
  String? get token => _token;

  bool get isLoggedIn => _user != null;

  bool get isAdmin => _user?.role == 'admin';
  bool get isPrzeslowy => _user?.role == 'przeslowy';
  bool get isMostowiak => _user?.role == 'mostowiak';

  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    _token = token;
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> loadToken() async {
    _token = await _storage.read(key: 'jwt_token');
    return _token;
  }

  // --- Instancje dostawców logowania ---

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Konstruktor ---

  AuthService() {
    // Przy starcie serwisu spróbuj automatycznie zalogować użytkownika
    _trySilentSignIn();
  }

  // --- Metody publiczne ---

  Future<void> _loadOrCreateUser(User firebaseUser) async {
    final userRef = _firestore.collection('users').doc(firebaseUser.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      // Tworzymy nowego użytkownika
      final newUser = AppUser(
        id: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'Nowy użytkownik',
        email: firebaseUser.email ?? '',
        pictureUrl: firebaseUser.photoURL,
        role: 'mostowiak',
        points: 0,
      );
      await userRef.set(newUser.toJson());
      _user = newUser;
    } else {
      _user = AppUser.fromJson(doc.data()!);
    }

    notifyListeners();
  }

  Stream<AppUser> streamUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
          (snap) => AppUser.fromJson(snap.data()!),
    );
  }

  /// Loguje użytkownika za pomocą konta Google.
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        _user = _createUserFromGoogle(googleUser);
        notifyListeners();
      }
    } catch (error) {
      debugPrint("Błąd podczas logowania przez Google: $error");
    }
  }

  /// Loguje użytkownika za pomocą konta Facebook.
  Future<void> signInWithFacebook() async {
    try {
      final result = await _facebookAuth.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await _facebookAuth.getUserData(
          fields:
              "name,email,picture.width(200)", // Sprecyzujmy jakie dane chcemy
        );
        _user = _createUserFromFacebook(userData);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Błąd logowania Facebookiem: $e');
    }
  }

  /// Wylogowuje użytkownika z obu usług i czyści dane w aplikacji.
  Future<void> signOut() async {
    // Wyloguj z obu dostawców, aby zapewnić czysty stan
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();

    _user = null;
    _token = null;
    await _storage.delete(key: 'jwt_token');
    notifyListeners();
  }

  // --- Metody prywatne (pomocnicze) ---

  /// Sprawdza przy starcie, czy istnieje aktywna sesja Google lub Facebook.
  Future<void> _trySilentSignIn() async {
    // Najpierw spróbuj cichego logowania z Google
    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signInSilently();
    if (googleUser != null) {
      _user = _createUserFromGoogle(googleUser);
      notifyListeners();
      return; // Znaleziono sesję Google, kończymy
    }

    // Jeśli nie ma sesji Google, sprawdź sesję Facebooka
    final accessToken = await _facebookAuth.accessToken;
    if (accessToken != null) {
      final userData = await _facebookAuth.getUserData(
          fields: "name,email,picture.width(200)");
      _user = _createUserFromFacebook(userData);
      notifyListeners();
    }
  }

  /// Tworzy obiekt AppUser na podstawie danych z Google.
  AppUser _createUserFromGoogle(GoogleSignInAccount googleUser) {
    return AppUser(
      id: googleUser.id,
      name: googleUser.displayName ?? 'Użytkownik Google',
      email: googleUser.email,
      pictureUrl: googleUser.photoUrl,
    );
  }

  /// Tworzy obiekt AppUser na podstawie danych z Facebooka.
  AppUser _createUserFromFacebook(Map<String, dynamic> userData) {
    return AppUser(
      id: userData['id'],
      name: userData['name'],
      email: userData['email'],
      pictureUrl: userData['picture']?['data']?['url'],
    );
  }

  Future<void> signup({
    required String email,
    required String password
  }) async {
    try {
            final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

            // await Future.delayed(const Duration(seconds: 1));
            // _user = _createUserFromFacebook(userData);

            final user = userCredential.user; // <-- To jest poprawne


            if (user == null) {
              throw Exception("Nie udało się utworzyć użytkownika");
            }
            await _loadOrCreateUser(user);

            notifyListeners();

    }on FirebaseAuthException catch (e){
      String message = '';
      if (e.code == 'weak-password'){
        message = 'The password provided is too weak.';
      }else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      print(message);
      // Fluttertoast.showToast(msg: message,
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.black54,
      //   fontSize: 14
      // );
    }
    catch(e){

    }
  }

  Future<bool> signin({
    required String email,
    required String password
  }) async {
    try {
      print("wysyłam dane do backendu:");
      final url = Uri.parse('http://192.168.1.100:8080/api/auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print("response z backendu:");
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // jeśli backend zwraca token JWT
        print("data z backendu:");
        print(data);
        _user = AppUser.fromMap(data); // <-- To jest poprawne
        await saveToken(data['token']); // Zapisujemy token
        notifyListeners();
        // return data['token'];
        return true;
      } else {
        print('Błąd logowania: ${response.body}');
        return false;
      }
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<void> signupWithFirebase({
    required String email,
    required String password
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      // await Future.delayed(const Duration(seconds: 1));
      // _user = _createUserFromFacebook(userData);

      final user = userCredential.user; // <-- To jest poprawne


      if (user == null) {
        throw Exception("Nie udało się utworzyć użytkownika");
      }
      await _loadOrCreateUser(user);

      notifyListeners();

    }on FirebaseAuthException catch (e){
      String message = '';
      if (e.code == 'weak-password'){
        message = 'The password provided is too weak.';
      }else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      print(message);
      // Fluttertoast.showToast(msg: message,
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.black54,
      //   fontSize: 14
      // );
    }
    catch(e){

    }
  }

  Future<bool> signinWithFirebase({
    required String email,
    required String password
  }) async {
    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      //
      // // await Future.delayed(const Duration(seconds: 1));
      // // _user = _createUserFromFacebook(userData);
      //
      //
      // print(FirebaseAuth.instance.currentUser);
      //
      // final user = FirebaseAuth.instance.currentUser;
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      print(_user);

      if (user != null) {
        _user = AppUser(
          id: user.uid,
          name: user.displayName ?? 'No Name',
          email: user.email ?? 'No Email',
        );
        print(_user?.email);
        notifyListeners();
        return true;
      } else {
        // Handle the case where there is no logged-in user
        print('No user is logged in');
        return false;
      }

    }on FirebaseAuthException catch (e){
      String message = '';
      if (e.code == 'user-not-found'){
        message = 'Nie ma takiego użytkownika.';
      }else if (e.code == 'wrong-password') {
        message = 'złe hasło';
      }
      print(message);

      return false;

      // Fluttertoast.showToast(msg: message,
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.black54,
      //   fontSize: 14
      // );
    }
    catch(e){
      return false;
    }
  }
}
