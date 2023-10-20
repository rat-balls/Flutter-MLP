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
      surfaceTintColor: Colors.white,
      shape: const LinearBorder(bottom: LinearBorderEdge()),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: const Color.fromARGB(255, 247, 184, 247),
                child: const Icon(
                  Icons.person,
                  size: 64,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  '${user.firstname} ${user.lastname}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
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
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 160, 0, 218),
                        side: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 160, 0, 218))),
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
