import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_sign_up/models/enums.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  Gender _gender = Gender.male;
  bool _tos = false;
  bool _signUp = false;

  @override
  Widget build(BuildContext context) => AdwClamp.scrollable(
        maximumSize: double.maxFinite,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'First Name',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: AdwTextField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Last Name',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: AdwTextField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Email',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: AdwTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Password',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: AdwTextField(
                      controller: _passwordController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Gender',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: Gender.values
                          .map(
                            (gender) => Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio<Gender>(
                                      value: gender,
                                      groupValue: _gender,
                                      onChanged: !_signUp
                                          ? (gender) => setState(() {
                                                _gender = gender!;
                                              })
                                          : null,
                                    ),
                                    Text(gender.name.toUpperCase()),
                                  ],
                                )),
                          )
                          .toList(growable: false),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Birth Date',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AdwTextField(
                        controller: _birthDateController,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ToS',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Checkbox(
                            value: _tos,
                            onChanged: (checked) {
                              if (!_signUp) {
                                setState(() {
                                  _tos = checked!;
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'I do agree terms and conditions',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: _signUp
                  ? const CircularProgressIndicator()
                  : AdwButton(
                      opaque: true,
                      backgroundColor: AdwDefaultColors.blue,
                      textStyle: const TextStyle(color: Colors.white),
                      child: const Text('Sign Up'),
                      onPressed: () async {
                        setState(() {
                          _signUp = true;
                        });

                        await Future.delayed(const Duration(seconds: 3));

                        setState(() {
                          _signUp = false;
                        });
                      },
                    ),
            ),
          ],
        ),
      );
  /*
      ScaffoldPage.scrollable(
        header: const PageHeader(title: Text('Sign Up')),
        children: [
          
        ],
      );

       */
}
