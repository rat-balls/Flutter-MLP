import 'package:flutter/material.dart';
import 'package:flutter_mlp/class/users/user.dart';
import 'package:flutter_mlp/widgets/profil/edit_user_form.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              color: const Color.fromARGB(255, 247, 184, 247),
              child: const Icon(Icons.person),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text('${user.firstname} ${user.lastname}'),
                Text('${user.age} ans'),
                Text(user.phonenumbers),
                Text(user.email),
                InkWell(
                  onTap: () {
                    _launchUrl(Uri.parse(user.ffe));
                  },
                  child: Text(
                    'FFE: ${user.ffe}',
                  ),
                ),
                ElevatedButton(
                    onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Modification du profil"),
                              content: EditUserForm(
                                user: user,
                              ),
                            );
                          },
                        ),
                    child: const Text("Modifier le profil"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
