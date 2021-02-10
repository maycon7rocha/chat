import 'dart:io';

import 'package:chat/models/auth_data.dart';
import 'package:chat/screens/widget/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_authData.image == null && _authData.isSigup) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('precisamos da sua foto!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return;
    }

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  void _handPickedImage(File image) {
    _authData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSigup) UserImagePicker(_handPickedImage),
                  if (_authData.isSigup)
                    TextFormField(
                      key: ValueKey('name'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      initialValue: _authData.name,
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no mínimo 4 caracteres.';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no mínimo 7 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      _authData.isLogin
                          ? 'Criar uma nova conta?'
                          : 'Já possui uma conta?',
                    ),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
