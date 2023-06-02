import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:traditional_financial_asistant/application/user/User_bloc.dart';
import 'package:traditional_financial_asistant/application/user/User_event.dart';
import 'package:traditional_financial_asistant/application/user/User_state.dart';
import 'package:traditional_financial_asistant/domain/register/User.dart';
import 'package:traditional_financial_asistant/domain/register/Username.dart';
// import 'package:traditional_financial_asistant/domain/auth/auth_domain_barell.dart';

import '../../../domain/auth/change_password.dart';
import '../../utilities/Input.dart';
import '../../utilities/curve_button.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  void initState() {
    super.initState();

    final UserEvent event = CurrentUserLoad();
    BlocProvider.of<UserBloc>(context).add(event);
    // Initialize your BLoC instance
    // Emit the desired event
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                context.goNamed('landing');
              },
            ),
        title: Text('My Account'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              context.goNamed("notification");
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UsersData) {
            Users userDetail = state.users;
            // TODO: implement listener}
          }
          ;
        },
        builder: (context, state) {
          TextEditingController? money = TextEditingController();
          if (state is UsersData) {
            Users userDetail = state.users;

            return SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(children: [
                    Container(
                      child: Image.asset('lib/presentation/images/profile.png'),
                      height: 185,
                      width: 250,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      userDetail.fullName.value.getOrElse(() => ""),
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "username: ${userDetail.username.value.getOrElse(() => "")}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "balance",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      NumberFormat.currency(symbol: 'ETB ').format(int.parse(
                          userDetail.balance.value.getOrElse(() => "0"))),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CurveButton(
                      color: Color(0xff6D968F),
                      text: 'Deposit',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Deposit Amount'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        InputFields(
                                            controller: money,
                                            placeholder: 'Amount',
                                            textInputType:
                                                TextInputType.number),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        CurveButton(
                                          color: Color(0xff6D968F),
                                          text: 'Deposit',
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.goNamed("welcome");
                                            final UserEvent event =
                                                MakePayement(int.parse(
                                                    money.text as String));
                                            BlocProvider.of<UserBloc>(context)
                                                .add(event);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context.goNamed("myAccount");
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        context.goNamed("welcome");
                      },
                    ),
                    CurveButton(
                      color: Color(0xff6D968F),
                      text: "change password",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ChangePasswordModal();
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // ListTile(
                    //   tileColor: Color(0xffBCCED3),
                    //   leading: Icon(Icons.group),
                    //   title: Text('total Equb joined: 5'),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    //   onTap: (){},
                    // ),
                    // SizedBox(height: 20.0,),
                    // ListTile(
                    //   tileColor: Color(0xffBCCED3),
                    //   leading: Icon(Icons.houseboat_rounded),
                    //   title: Text('total Edir joined: 5'),
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    //   onTap: (){},
                    // ),
                  ]),
                ),
              ),
            );
          } else {
            return Center(child: Text("Please Login"));
          }
        },
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return AlertDialog(
            title: Text('Confirm Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is LogoutSuccesfull) {
                    context.goNamed('login');
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    child: Text('Logout'),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(UserLogout());
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    },
  );
}

class ChangePasswordModal extends StatefulWidget {
  @override
  _ChangePasswordModalState createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final _formKey = GlobalKey<FormState>();
  late String _oldPassword;
  late String _newPassword;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change Password'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Old Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your old password';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _oldPassword = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your new password';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _newPassword = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is LogoutSuccesfull) {
              context.goNamed('login');
            } else if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('operation successfull')));
              BlocProvider.of<UserBloc>(context).add(UserLogout());
              // context.goNamed('login');
              // Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Unable to change password')));
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<UserBloc>(context).add(ChangePassword(
                      ChangePasswordModel(
                          oldpassword: _oldPassword,
                          newpassword: _newPassword)));
                }
              },
              child: Text('Submit'),
            );
          },
        ),
      ],
    );
  }
}

// To open the change password modal using showDialog:
