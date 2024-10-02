import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = "/loginPage";
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passController;
  final _formKey = GlobalKey<FormState>();
  bool _visibility = true;


  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;

  void login(){
    _auth.signInWithEmailAndPassword(email: emailController.text, password: passController.text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful")));
      Navigator.popAndPushNamed(context, '/homepage');
    }).onError((handleError, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Incorrect Password or Email")));
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Text("Login", style: Theme.of(context).textTheme.headlineLarge,)
          ),
          SizedBox(
            height: screenHeight*0.02,
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                ),
                SizedBox(height: screenHeight * 0.05,),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: (_visibility)? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },  
                    )
                  ),
                  validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  obscureText: _visibility,
                ),
                SizedBox(height: screenHeight * 0.05,),
                ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(minimumSize: WidgetStatePropertyAll(Size(screenWidth*0.6, screenHeight*0.05))),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      login();
                    }
                  }, 
                  child: const Text("Login"),
                )
              ],
              ),
            )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dont have an account?"),
              TextButton(onPressed: (){
                  Navigator.popAndPushNamed(context, "/signUpPage");
              }, child: const Text("SignUp"))
            ],
          )
        ],
      ),
    );
  }
}