import 'dart:core';
import 'dart:ui';
import 'add_user.dart';
import 'package:admin_screen/widgets/display_user.dart';
import '../providers/portfolio_provider.dart';
import '../providers/search_results_provider.dart';
import 'package:admin_screen/services/requests_to_backend.dart';
import '../providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'user_details.dart';

class AdminUser extends StatefulWidget {
  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  bool fetchingUsers = false;
  List<dynamic>? users;
  Color primaryLight = Color(0xFFEFF7FF);
  OverlayEntry? searchResults;

  Future<void> fetchUsers() async {
    fetchingUsers = true;
    users = await Api.fetchUsers();
    fetchingUsers = false;
    setState(() {});
  }

  void addUserScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Adduser();
    }));
  }

  OverlayEntry showSearchResults(
      context, usersProvider, searchResultsProvider) {
    final screenSize = MediaQuery.of(context).size;
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 20,
          top: 60,
          width: screenSize.width * 0.5,
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(15),
            elevation: 1.5,
            child: Container(
              constraints: BoxConstraints(
                maxHeight:
                    screenSize.height <= 300 ? 135 : screenSize.height * 0.5,
              ),
              child: Selector<SearchResultsProvider, List<dynamic>>(
                selector: (context, provider) => provider.searchResults,
                builder: (context, searchResults, child) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: searchResults
                        .map((user) => InkWell(
                              onTap: () {
                                usersProvider.selectedUser = user;
                                searchResultsProvider
                                    .updateSearchingStarted(false);
                              },
                              child: ListTile(
                                title:
                                    Text(user.firstName + " " + user.lastName),
                                subtitle: Text(user.portfolio),
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    Provider.of<PortfolioProvider>(context, listen: false).initialise();
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final searchResultsProvider = Provider.of<SearchResultsProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    print(screenSize.width);
    if (users == null && !fetchingUsers) fetchUsers();
    if (users != null && usersProvider.rowList == null)
      usersProvider.initialise(context, users!);
    return Scaffold(
      backgroundColor: primaryLight,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth_desktop_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Column(
            children: [
              Card(
                color: Colors.grey[600],
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        height: 50,
                        child: TextField(
                          cursorColor: Colors.black,
                          cursorHeight: 25,
                          cursorWidth: 3.2,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            hintText: "Search by name or portfolio",
                            hintStyle: GoogleFonts.notoSans(),
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (newValue) {
                            if (newValue.length == 0) {
                              searchResults!.remove();
                              searchResultsProvider.searchResults = [];
                              searchResultsProvider.searchingStarted = false;
                              return;
                            }

                            if (!searchResultsProvider.searchingStarted) {
                              searchResults = showSearchResults(context,
                                  usersProvider, searchResultsProvider);
                              Overlay.of(context)?.insert(searchResults!);
                              searchResultsProvider.searchingStarted = true;
                            }

                            searchResultsProvider.searchValue = newValue;
                            searchResultsProvider
                                .generateSearchResults(usersProvider);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        onPressed: () {},
                        hoverColor: Colors.black38,
                        splashRadius: 20,
                        icon: Icon(Icons.notifications),
                        tooltip: "Notification",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'SoftDoc',
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'admin',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  child: usersProvider.rowList == null
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            color: Colors.green,
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              UserDetails(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 50, 5),
                                child: Display(),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addUserScreen(context);
        },
        label: Row(
          children: [
            Selector<SearchResultsProvider, bool>(
              selector: (context, provider) => provider.searchingStarted,
              builder: (context, searchingStarted, child) {
                if (!searchingStarted &&
                    searchResults != null &&
                    searchResults!.mounted) searchResults?.remove();
                return Icon(
                  Icons.add,
                  size: 35,
                );
              },
            ),
            if (screenSize.width > 1000) SizedBox(width: 8),
            if (screenSize.width > 1000) Text('Add user'),
          ],
        ),
      ),
    );
  }
}
