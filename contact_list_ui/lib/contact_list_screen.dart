import 'package:flutter/material.dart';

import 'basictextfield.dart';
import 'contact_card.dart';
import 'contact_model.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Sample Data
    final List<Contact> contacts = [
      const Contact(name: 'Jameel', phone: '01877-777777'),
      const Contact(name: 'Hasan', phone: '01766-777777'),
      const Contact(name: 'Faridpur', phone: '01756-777777'),
      const Contact(name: 'Hasan', phone: '01745-777777'),
      const Contact(name: 'Hasan', phone: '01735-777777'),
      const Contact(name: 'Hridoy', phone: '01725-777777'),
      const Contact(name: 'Hasan', phone: '01715-777777'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Input Fields
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Name Field
                const BasicTextField(
                  icon: Icon(Icons.person),
                  hintText: 'Name',
                ),
                const SizedBox(height: 12),
                
                // Phone Field
                const BasicTextField(
                  icon: Icon(Icons.phone),
                  hintText: 'Phone Number',
                ),
                const SizedBox(height: 16),
                
                // Add Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Contact',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contacts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: contacts.length,
              itemBuilder: (context, index) => ContactCard(contact: contacts[index]),
            ),
          ),
        ],
      ),
    );
  }
}


