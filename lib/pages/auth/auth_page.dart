import 'package:flutter/material.dart';
import 'package:walkie_talkie/models/userdata/register_user.dart';
import 'package:walkie_talkie/models/userdata/user_data.dart';
import 'package:walkie_talkie/pages/auth/email_phone_page.dart';
import 'package:walkie_talkie/pages/auth/gender_page.dart';
import 'package:walkie_talkie/pages/auth/image_bio_page.dart';
import 'package:walkie_talkie/pages/auth/password_page.dart';
import 'package:walkie_talkie/services/auth/auth_service.dart';

import '../../constants/app_routes.dart';
import 'name_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  final int pageCount = 5;

  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _goToHome() {
    Navigator.pushNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == pageCount - 1;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 40, 69),
      body: SafeArea(
        child: Column(
          children: [

            /// Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pageCount,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: switch (index) {
                        0 => const NamePage(),
                        1 => const EmailPhonePage(),
                        2 => const PasswordPage(),
                        3 => const GenderPage(),
                        4 => const ImageBioPage(),
                        _ => const SizedBox(),
                      },
                    ),
                  );
                },
              ),
            ),

            /// Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pageCount, (index) {
                final bool isSelected = index == _currentIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: isSelected ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.lightBlueAccent
                        : Colors.grey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            /// Prev / Next / Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _prevPage,
                    child: Text(
                      "Prev",
                      style: TextStyle(
                        color: _currentIndex == 0
                            ? Colors.lightBlueAccent.withValues(alpha: 0.4)
                            : Colors.lightBlueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      if (isLastPage) {
                        _authService.userRegister(
                            RegisterUser(firstName: UserData.instance.firstName,
                                lastName: UserData.instance.lastName,
                                email: UserData.instance.email,
                                phoneNumber: UserData.instance.phone,
                                password: UserData.instance.password,
                                password2: UserData.instance.password,
                                gender: UserData.instance.gender,
                                imageUrl: UserData.instance.image,
                                bio: UserData.instance.bio)
                        );
                      _goToHome();
                    } else {
                        _nextPage();
                      }
                    },
                    child: Text(
                      isLastPage ? "Start" : "Next",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
