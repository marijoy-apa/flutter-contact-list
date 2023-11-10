import 'package:flutter/material.dart';

Widget addButton({required onChange}) => Align(
                
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: TextButton.icon(
                    onPressed: onChange,
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color.fromARGB(255, 101, 199, 100),
                    ),
                    label: const Text(
                      'Add phone',
                    ),
                  ),
                ),
              );