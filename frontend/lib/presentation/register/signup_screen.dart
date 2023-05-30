// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/domain/register/User.dart';
import 'package:traditional_financial_asistant/domain/register/blance.dart';
import 'package:traditional_financial_asistant/domain/register/email.dart';
import 'package:traditional_financial_asistant/infrastructure/register/signup_repository.dart';
import 'package:traditional_financial_asistant/application/register/signup_bloc.dart';
import 'package:traditional_financial_asistant/application/register/signup_event.dart';
import 'package:traditional_financial_asistant/application/register/signup_state.dart';

import '../../domain/register/Password.dart';
import '../../domain/register/Username.dart';
import '../../domain/register/fullname.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _balance = TextEditingController();
  final TextEditingController _fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignupBloc, SignupState>(
            bloc: BlocProvider.of<SignupBloc>(context),
            listener: (context, state) {
              if (state is SignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("regisetered succesfully"),
                  duration: Duration(seconds: 2),
                ));
                context.goNamed("login");
              } else if (state is SignupInitial) {
              } else if (state is SignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                if (state is SignupLoading) {
                  // Show a loading indicator while sign-up is in progress
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    height: 1000,
                    child: SingleChildScrollView(
                      // color: Color.fromARGB(255, 254, 17, 17),
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Stack(children: [
                            ClipPath(
                              clipper: OvalBottomBorderClipper(),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                color: Color.fromARGB(255, 02, 30, 66),
                                child: Center(
                                  child: Text(""),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.18,
                              left: 20,
                              right: 20,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
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
                                      "Signup",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 02, 30, 66),
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _fullName,
                                        decoration: InputDecoration(
                                            hintText: 'Full Name'),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                            hintText: 'UserName'),
                                         

                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                            hintText: 'Password'),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _email,
                                        decoration: InputDecoration(
                                            hintText: 'email'),
                                        
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: _balance,
                                        decoration: InputDecoration(
                                            hintText: 'balance'),
                                        
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final user = Users(
                                          // name: _nameController.text,
                                          fullName: FullName(
                                              _fullName.text),
                                          username: Username(
                                              _usernameController.text),
                                          password: Password(
                                              _passwordController.text),
                                          email: Email(_email.text),
                                          balance: Balance(_balance.text),
                                        );
                                        final SignupEvent event =
                                            SignupButtonPressed(user);
                                        context.read<SignupBloc>().add(event);
                                      },
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                      ),
                                    )
                                  ,],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have an account? "),
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed('login');
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          // color: Colors.purple[900],
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
                      ]),
                    ),
                  );
                }
              });
            }));
  }
}
