import 'package:chat/models/auth_data.dart';
import 'package:chat/screens/widget/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleSubmit(AuthData authData) async {
    print(authData.email);
    try {
      if (authData.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      }
    } on PlatformException catch (e) {
      final msg = e.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
      _scaffoldKey.currentState.showSnackBar(
        
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_handleSubmit),
    );
  }
}
