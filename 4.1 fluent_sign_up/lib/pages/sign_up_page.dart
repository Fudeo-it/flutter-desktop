import 'package:fluent_sign_up/models/enums.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
  Widget build(BuildContext context) => ScaffoldPage.scrollable(
        header: const PageHeader(title: Text('Sign Up')),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'First Name',
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextBox(
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
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextBox(
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
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextBox(
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
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextBox(
                    placeholder: 'Password',
                    controller: _passwordController,
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
                    'Gender',
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: Gender.values
                        .map(
                          (gender) => Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: RadioButton(
                              checked: gender == _gender,
                              onChanged: (selected) {
                                if (!_signUp && selected) {
                                  setState(() {
                                    _gender = gender;
                                  });
                                }
                              },
                              content: Text(gender.name.toUpperCase()),
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
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DatePicker(
                      selected: _birthDate,
                      onChanged: (date) {
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
                    style: FluentTheme.of(context).typography.caption,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Checkbox(
                          checked: _tos,
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
                          style: FluentTheme.of(context).typography.caption!,
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
                ? const ProgressRing()
                : FilledButton(
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
      );
}
