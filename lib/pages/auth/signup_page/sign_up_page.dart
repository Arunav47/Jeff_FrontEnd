import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_support_chatbot/services/database_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = "/signUpPage";


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = "", _userName = "", _password = "";
  late TextEditingController emailController;
  late TextEditingController passController; 
  late TextEditingController userNameController; 
  final _formKey = GlobalKey<FormState>();

  
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    userNameController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    userNameController.dispose();
  }

  void registration() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      await userCredential.user!.updateDisplayName(userNameController.text);
      Map<String, dynamic> userInfoMap = {
        "userName": userNameController.text,
        "email": emailController.text
      };
      DatabaseMethod().addUser(userCredential.user!.uid, userInfoMap);
      if(userCredential.user != null){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful")));
        Navigator.popAndPushNamed(context, "/homepage");
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password is too weak")));
      }
      else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email is already in use")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                  children: [
                    TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.05,),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Email cannot be empty";
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
                        icon: const Icon(Icons.visibility),
                        onPressed: (){},  
                      )
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                    SizedBox(height: screenHeight * 0.05,),
                    ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(minimumSize: WidgetStatePropertyAll(Size(screenWidth*0.6, screenHeight*0.05))),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            _email = emailController.text;
                            _userName = userNameController.text;
                            _password = passController.text;
                            registration();
                          });
                        }
                      }, 
                      child: const Text("SignUp"),
                    )
                  ],
                ),
              )),
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(onPressed: (){
                  Navigator.popAndPushNamed(context, '/loginPage');
              }, child: const Text("Login"))
            ],
          )
          ],
        ),
      ),
    );
  }
}