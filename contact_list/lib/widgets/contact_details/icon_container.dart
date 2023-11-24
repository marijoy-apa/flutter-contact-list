import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.onCall,
    required this.state,
  });

  final IconData icon;
  final String label;
  final Function() onCall;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCall,
      child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 70,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: state
                  ? Colors.blue
                  : Theme.of(context).iconTheme.color!.withOpacity(0.3),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                color: state
                    ? Colors.blue
                    : Theme.of(context).iconTheme.color!.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
