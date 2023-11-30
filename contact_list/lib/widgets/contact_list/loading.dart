import 'package:flutter/material.dart';

Widget loadingWidget(String searchItem, BuildContext context) => Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Theme.of(context).iconTheme.color,),
          ],
        ),
      ),
    );
