import 'package:flutter/material.dart';

Widget noListAdded(String list, BuildContext context) => Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 40,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 220,
              child: Text(
                'No $list',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$list you've added will appear here",
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
            )
          ],
        ),
      ),
    );
