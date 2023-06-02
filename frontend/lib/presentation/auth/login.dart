import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/authentication_bloc.dart';
import '../../domain/auth/password.dart';
import '../../domain/auth/User.dart';
import '../../domain/auth/username.dart';
import '../../infrastructure/auth/authentication_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider<AuthenticationBloc>(
//         create: (context) => AuthenticationBloc(
//          context.read<AuthenticationRepository>(),
//         ),
//         child: Login(),
//       ),
//     );
//   }
// }
class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('here we go');

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (context, state) {
        print(state);
        if (state is AuthenticationAuthenticated) {
          print('authenticated');
          final snackBar = SnackBar(
            content: Text('authenticated!'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.goNamed('landing');
        } else if (state is AuthenticationFailure) {
          print('Inavlid values');
          final snackBar = SnackBar(
            content: Text('In valid values!'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is AuthenticationUnauthenticated) {
          print('unauthenticated');
          final snackBar = SnackBar(
            content: Text('un Authenticated!'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) => Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: OvalBottomBorderClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          color: Color.fromARGB(255, 2, 30, 66),
                          child: Center(child: Text("")),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.18,
                          left: 20,
                          right: 20,
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.62,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 2, 30, 66),
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    TextField(
                                      key: Key('username'),
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                          labelText: 'username'),
                                    ),
                                    SizedBox(height: 20),
                                    TextField(
                                      key: Key('password'),
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                          labelText: 'Password'),
                                      obscureText: true,
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      key: Key('login_user'),
                                      onPressed: () {
                                        final username =
                                            _usernameController.text;
                                        final password =
                                            _passwordController.text;
                                        final user = User(
                                            username: Username(username),
                                            password: Password(password));
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(LoginEvent(user));
                                      },
                                      child: Text('Login'),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed('signup');
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          // color: Colors.purple[900],
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
