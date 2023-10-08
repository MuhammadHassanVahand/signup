import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:signup/authentication/signup.dart';
import 'package:signup/customWidget/customFormBilder.dart';
import 'package:signup/customWidget/cutomButton.dart';
import 'package:signup/screens/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;
  bool isLogin = false;

  loginProccess(emailAddress, password) async {
    try {
      isLogin = true;
      setState(() {});
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Loggin Successful"),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      isLogin = false;
      setState(() {});
    } catch (e) {
      isLogin = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email or password is invalid"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://cdn.dribbble.com/users/1767962/screenshots/5986027/media/909e0b24e8f2b3fd12e409e0c1f622d6.gif",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomBuilderText(
                        controller: emailController,
                        formTextName: "email",
                        labelText: "Email Address",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.email(),
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomBuilderText(
                        controller: passwordController,
                        formTextName: "password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureText = !obscureText;
                            setState(() {});
                          },
                          icon: obscureText == true
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        obscureText: obscureText,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final formData = _formKey.currentState!.value;
                            final emailAddress = formData["email"];
                            final password = formData["password"];
                            loginProccess(emailAddress, password);
                            print(formData);
                          }
                        },
                        buttonText: "Sign in",
                        backgroundColor: Colors.cyan,
                        textColor: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        fontWeight: FontWeight.bold,
                        size: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ));
                        },
                        buttonText: "Sign Up",
                        backgroundColor: Colors.white,
                        textColor: Colors.cyan,
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        fontWeight: FontWeight.bold,
                        size: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: isLogin,
                        child: const CircularProgressIndicator(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
