import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class FooPage extends StatelessWidget {
  const FooPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Text("hello")
    );
  }

}