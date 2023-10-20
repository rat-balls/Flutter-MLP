import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/auth.dart';
import 'package:flutter_mlp/database/db_class.dart';
import 'package:flutter_mlp/pages/home_page.dart';
import 'package:flutter_mlp/pages/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  final List<User> users = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController() ;
  final TextEditingController passwordController = TextEditingController() ;
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      
      body:
        Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) => nameController,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: InputDecoration(labelText: 'Veuillez saisir votre email'),
                ),
                TextFormField(
                  onChanged: (value) => passwordController,
                  validator: (value) => value!.isEmpty ? 'Champ requis' : null,
                  decoration: const InputDecoration(labelText: 'Veuillez saisir votre mot de passe'),
                ),
                ElevatedButton(
                onPressed: () async {
                
                    print("Clicked");
                    bool isAuthenticated = await DbConnect.loginUser(
                      context,
                      nameController.text,
                      passwordController.text,
                    );  
                    if (isAuthenticated) {
                        print("test");
                        Navigator.pushNamed(context, '/');
    
                    } else {
                      print("test2");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nom d\'utilisateur ou mot de passe incorrect')),);}
                
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

