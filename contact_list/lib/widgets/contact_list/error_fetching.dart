import 'package:flutter/material.dart';

Widget errorMessage(String errorMessage, BuildContext context) => Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
            )
          ],
        ),
      ),
    );
