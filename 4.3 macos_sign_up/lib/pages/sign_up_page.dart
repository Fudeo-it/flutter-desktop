import 'package:flutter/cupertino.dart';
import 'package:macos_sign_up/models/enums.dart';
import 'package:macos_ui/macos_ui.dart';

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

  Gender _gender = Gender.male;
  DateTime _birthDate = DateTime.now();
  bool _tos = false;
  bool _signUp = false;

  @override
  Widget build(BuildContext context) => MacosScaffold(
        toolBar: const ToolBar(title: Text('Sign Up')),
        children: [
          ContentArea(
            builder: (context, scrollController) => SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              controller: scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'First Name',
                            style: MacosTheme.of(context).typography.caption1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: MacosTextField(
                            placeholder: 'First Name',
                            controller: _firstNameController,
                            enabled: !_signUp,
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
                            style: MacosTheme.of(context).typography.caption1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: MacosTextField(
                            placeholder: 'Last Name',
                            controller: _lastNameController,
                            enabled: !_signUp,
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
                            style: MacosTheme.of(context).typography.caption1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: MacosTextField(
                            placeholder: 'Email',
                            controller: _emailController,
                            enabled: !_signUp,
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
                            style: MacosTheme.of(context).typography.caption1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: MacosTextField(
                            placeholder: 'Password',
                            controller: _passwordController,
                            enabled: !_signUp,
                            obscureText: true,
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
                            style: MacosTheme.of(context).typography.caption1,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MacosRadioButton(
                                          value: gender,
                                          groupValue: _gender,
                                          onChanged: !_signUp
                                              ? (selected) => setState(() {
                                                    _gender = gender;
                                                  })
                                              : null,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            gender.name.toUpperCase(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
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
                            style: MacosTheme.of(context).typography.caption1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: MacosDatePicker(
                              style: DatePickerStyle.textual,
                              onDateChanged: (date) {
                                if (!_signUp) {
                                  setState(() {
                                    _birthDate = date;
                                  });
                                }
                              },
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
                            style: MacosTheme.of(context).typography.caption1,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              MacosCheckbox(
                                  value: _tos,
                                  onChanged: !_signUp ? (checked) {
                                      setState(() {
                                        _tos = checked;
                                      });
                                  } : null),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'I do agree terms and conditions',
                                  style: MacosTheme.of(context)
                                      .typography
                                      .caption1,
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
                        ? const ProgressCircle()
                        : PushButton(
                            buttonSize: ButtonSize.large,
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
            ),
          ),
        ],
      );
}
