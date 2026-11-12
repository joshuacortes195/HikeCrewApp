import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/labeled_field.dart';
import 'home_shell.dart';

// first screen you see, no real auth yet
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // cleans up the text fields when the screen goes away
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // takes you into the app and drops login from the back stack
  void _goToHome() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const HomeShell()));
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _header(),

            // headline, form and links
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Better trails.\nEven better company.',
                    style: text.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Find your people. Make a plan. Head outside.',
                    style: text.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Your next adventure starts here',
                    style: text.titleLarge?.copyWith(fontSize: 21),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Log in to find a hike and meet your crew.',
                    style: text.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // email and password fields
                  LabeledField(
                    label: 'Email',
                    hint: 'you@example.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  LabeledField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    obscureText: true,
                  ),

                  // forgot password does nothing yet
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 8),

                  FilledButton(
                    onPressed: _goToHome,
                    child: const Text('Log in'),
                  ),
                  const SizedBox(height: 12),

                  // sign up link, also goes straight in for now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to the crew?',
                        style: text.bodyLarge?.copyWith(
                          color: AppColors.darkGreen,
                        ),
                      ),
                      TextButton(
                        onPressed: _goToHome,
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'By continuing, you agree to our Terms & Privacy.',
                      style: text.bodySmall,
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

  // rock photo with the hike crew logo pill on top
  Widget _header() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/rock.jpg',
          height: 270,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: const ShapeDecoration(
              color: AppColors.cream,
              shape: StadiumBorder(),
            ),
            // styling for the logo
            child: Row(
              children: [
                const Icon(
                  Icons.landscape_outlined,
                  color: AppColors.darkGreen,
                ),
                const SizedBox(width: 8),
                Text(
                  'hike crew',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: AppColors.darkGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
