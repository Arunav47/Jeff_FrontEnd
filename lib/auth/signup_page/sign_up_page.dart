import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController passController; 
  late TextEditingController userNameController; 
  
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
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Text("Login", style: Theme.of(context).textTheme.headlineLarge,)
          ),
          SizedBox(
            height: screenHeight*0.02,
          ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05,),
                  TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
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
                  obscureText: true,
                ),
                  SizedBox(height: screenHeight * 0.05,),
                  ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(minimumSize: WidgetStatePropertyAll(Size(screenWidth*0.6, screenHeight*0.05))),
                    onPressed: (){}, 
                    child: const Text("SignUp"),
                  )
                ],
            )),
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(onPressed: (){}, child: Text("Login"))
            ],
          )
          ],
        ),
      ),
    );
  }
}