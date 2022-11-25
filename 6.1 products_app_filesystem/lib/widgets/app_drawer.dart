import 'package:flutter/material.dart';
import 'package:products_app/routing/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Row(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(),
                    accountName: Text(
                      'Angelo Cassano',
                      style: TextStyle(color: Colors.black87),
                    ),
                    accountEmail: Text(
                      'angelo@fudeo.it',
                      style: TextStyle(color: Colors.black87),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.android),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Products'),
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.products);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add Product'),
                    onTap: () async {
                      await Navigator.pushReplacementNamed(
                          context, RouteNames.add);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
