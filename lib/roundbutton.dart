import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key, required this.title, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: onTap,
        child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff2A3C24),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(child: loading ? CircularProgressIndicator( strokeWidth: 2,color: Colors.white,) : Text(title, style: TextStyle(color: Colors.white),)),
            ),
      );
  }
}
