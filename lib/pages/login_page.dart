import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/auth.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/register_page.dart';
import 'package:flutter_mlp/widgets/controllerPage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final List<User> users = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration:
                  InputDecoration(labelText: 'Veuillez saisir votre email'),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: const InputDecoration(
                  labelText: 'Veuillez saisir votre mot de passe'),
            ),
            ElevatedButton(
              onPressed: () async {
                print("Clicked");
                bool isAuthenticated = await User.loginUser(
                  emailController.text,
                  passwordController.text,
                );

                if (isAuthenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ControllerPage()),
                  );
                  print("user connected");
                  print(User.currentUser.id);
                } else {
                  print("test2");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Nom d\'utilisateur ou mot de passe incorrect')),
                  );
                }
              },
              child: Text('Connexion'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
