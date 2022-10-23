import 'package:flutter/material.dart';
import 'package:flutter_restaurant/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final baseUrl =
      "https://kober.digitaloka.id/admin/storage/app/public/profile";
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profil, child) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage: AssetImage(
                "assets/image/kobercoin.png",
              ),
            ),
            title: Text("${profil.userInfoModel.point}"),
            subtitle: const Text("Kober Coin"),
          ),
        );
      },
    );
  }
}
