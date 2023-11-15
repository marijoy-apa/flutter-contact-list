import 'package:flutter/material.dart';

Widget loadingWidget(String searchItem, BuildContext context) => Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Theme.of(context).iconTheme.color,),
            // SizedBox(height: 20),
            // Text(
            //   'Fetching data. Please wait for a moment.',
            //   style: TextStyle(
            //     color: Theme.of(context).iconTheme.color,
            //   ),
            // )
          ],
        ),
      ),
    );
