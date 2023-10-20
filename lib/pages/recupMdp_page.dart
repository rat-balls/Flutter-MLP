import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';

class RecupMdpPage extends StatefulWidget{
  const RecupMdpPage({super.key});
  @override
  RecupMdpPageState createState() => RecupMdpPageState();
}

class RecupMdpPageState extends State<RecupMdpPage>{
  List<User>? users = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var mdp;

  Future<String> recupMdp(String mail) async {
    users = await User.getAllUser();
    for (User user in users!){
      if (mail == user.email){
        return 'Votre mot de passe est ${user.email}';
      }
    }
    return 'Adresse mail inconnu';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),

      body:
      Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              decoration: InputDecoration(labelText: 'Veuillez saisir votre email'),
            ),
            ElevatedButton(
              onPressed: () async {
                var mdp = recupMdp(emailController.toString());
              },

              child: Text(mdp),
            ),
          ],
        ),
      ),

    );

  }
}

