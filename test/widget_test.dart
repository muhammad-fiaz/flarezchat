import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flarezchat/main.dart';
import 'package:flarezchat/app/screens/pages/HomeScreen.dart';
import 'package:flarezchat/app/screens/intro/onBoardingScreens/view/onBoardingScreen.dart';

void main() {
  testWidgets('Test app behavior based on onboarding completion', (WidgetTester tester) async {
    // Mock the SharedPreferences instance
    SharedPreferences.setMockInitialValues({'onboarding_complete': true});

    // Build the app with onboarding complete
    await tester.pumpWidget(const MyApp(onboardingComplete: true));

    // Verify that the HomeScreen is displayed
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(onBoardingScreenHome), findsNothing);

    // Build the app with onboarding incomplete
    await tester.pumpWidget(const MyApp(onboardingComplete: false));

    // Verify that the OnboardingScreen is displayed
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(onBoardingScreenHome), findsNothing);
  });
}
