import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:signup/authentication/signin.dart';
import 'package:signup/customWidget/customFormBilder.dart';
import 'package:signup/screens/homescreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool obscureText = true;
  bool isSignup = false;

  Future<void> signupAuth(
    emailAddress,
    password,
    formData,
    name,
    dateOfBirth,
    phoneNumber,
    gender,
  ) async {
    try {
      isSignup = true;
      setState(() {});

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'full name': name,
        'email': emailAddress,
        'date of birth': dateOfBirth,
        'phone number': phoneNumber,
        'gender': gender,
      });

      emailController.clear();
      passordController.clear();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign up successfull"),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      isSignup = false;
      setState(() {});
      print(formData);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isSignup = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        isSignup = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The account already exists for that email."),
          ),
        );
      }
    } catch (e) {
      isSignup = false;
      setState(() {});
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://miro.medium.com/v2/resize:fit:1400/1*BJHpzKGCqf7TrVQb96656Q.gif"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Stack(
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomBuilderText(
                          formTextName: "full name",
                          labelText: "Full Name",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        CustomBuilderText(
                          controller: emailController,
                          formTextName: "email",
                          labelText: "Email",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        CustomBuilderText(
                          formTextName: "phone number",
                          labelText: "Phone Number",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.minLength(10),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        CustomBuilderText(
                          controller: passordController,
                          formTextName: "password",
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(8),
                          ]),
                          obscureText: obscureText,
                        ),
                        const SizedBox(height: 20),
                        CustomBuilderText(
                          formTextName: "confirm_password",
                          labelText: "Confirm Password",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => _formKey.currentState
                                      ?.fields['password']?.value !=
                                  value
                              ? "No Coinciden"
                              : null,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          obscureText: obscureText,
                        ),
                        const SizedBox(height: 20),
                        CustomBuilderDateOfBirth(
                          formFieldName: "date_of_birth",
                          labelText: "Date_of_Birth",
                          validator: (value) {
                            if (value == null) {
                              return 'Date of birth is required';
                            }

                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GenderDropdown(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final formData = _formKey.currentState!.value;
                              final emailAddress = formData["email"];
                              final password = formData["password"];
                              final fullName = formData["full name"];
                              final phoneNumber = formData["phone number"];
                              final gender = formData["gender"];
                              final dateOfBirth = formData["date_of_birth"];
                              await signupAuth(
                                emailAddress,
                                password,
                                formData,
                                fullName,
                                dateOfBirth,
                                phoneNumber,
                                gender,
                              );
                            }

                            const CircularProgressIndicator();
                          },
                          child: Text('Sign Up'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Visibility(
                              visible: isSignup,
                              child: const CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
