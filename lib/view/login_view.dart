import 'package:bloc_learning/controller/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late FocusNode passwordNode;
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    passwordNode = new FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.error?.status == true) {
          final snackBar = SnackBar(
            content: Text(state.error!.value!),
            action: SnackBarAction(
              label: "OK", 
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
          context.read<LoginBloc>().add(LoginErrorHasRetrieve());
        }

        if (state.success == true) {
          final snackBar = SnackBar(
            content: Text("Successfully login"),
            action: SnackBarAction(
              label: "OK", 
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login")
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text("Please login first to access this application")
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter your username",
                            labelText: "Username"
                          ),
                          autocorrect: false,
                          enableSuggestions: false,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "You must fill this field";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            context.read<LoginBloc>().add(LoginUsernameChanged(value));
                          },
                        ),
                        TextFormField(
                          focusNode: passwordNode,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            labelText: "Password"
                          ),
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "You must fill this field";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            context.read<LoginBloc>().add(LoginPasswordChanged(value));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.login),
                            label: Text("Login"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(LoginSubmitted());
                              }
                            }
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ),
    );
  }
}