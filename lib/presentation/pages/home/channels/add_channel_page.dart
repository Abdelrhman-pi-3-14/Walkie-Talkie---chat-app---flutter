// presentation/pages/home/channels/add_channel_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../../constants/rosponsive_helper.dart';

class AddChannelPage extends StatefulWidget {
  const AddChannelPage({super.key});

  @override
  State<AddChannelPage> createState() => _AddChannelPageState();
}

class _AddChannelPageState extends State<AddChannelPage> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  String _searchContact = "";

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
      });
    }
  }

  void _onSearch(String value) {
    setState(() {
      _searchContact = value;
      _filteredContacts = _contacts.where((contact) {
        return contact.displayName.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xFF041f45),
      body: Column(
        children: [
          Container(
            height: r.h(0.15),
            color: const Color(0xFF041f45),
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF00BBFF),
                    ),
                  ),
                  const SizedBox(width: 24),
                  const Text(
                    " Add New Walkie Talkie Channel ",
                    style: TextStyle(
                      color: Color(0xFF00BBFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'digital',
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Body
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),

                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: TextField(
                                onChanged: _onSearch,
                                decoration: InputDecoration(
                                  hintText: 'Search contact',
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xFF00BBFF),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            Expanded(
                              child: _filteredContacts.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "No Contact Found :( ",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                103,
                                                135,
                                                133,
                                                133,
                                              ),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Image(
                                            image: AssetImage(
                                              "assets/images/no_result.png",
                                            ),
                                            width: 200,
                                            height: 200,
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: _filteredContacts.length,
                                      itemBuilder: (context, index) {
                                        final contact =
                                            _filteredContacts[index];
                                        return ListTile(
                                          leading: contact.photo != null
                                              ? CircleAvatar(
                                                  backgroundImage: MemoryImage(
                                                    contact.photo!,
                                                  ),
                                                )
                                              : const CircleAvatar(
                                                  child: Icon(Icons.person),
                                                ),
                                          title: Text(contact.displayName),
                                          subtitle: Text(
                                            contact.phones.isNotEmpty
                                                ? contact.phones.first.number
                                                : "No phone number",
                                          ),
                                          onTap: () {
                                            debugPrint(
                                              "Tapped: ${contact.displayName}",
                                            );
                                          },
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
