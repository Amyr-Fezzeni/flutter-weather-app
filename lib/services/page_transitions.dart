import 'package:flutter/material.dart';


/// Route personnalisée pour une transition de diapositive animée lors de la navigation.
///
/// Utilise `PageRouteBuilder` pour créer une transition de page personnalisée avec effet de glissement.
///
/// Exemple d'utilisation:
/// ```dart
/// Navigator.push(context, SlideTransition1(screen));
/// ```
class SlideTransition1 extends PageRouteBuilder {
  final Widget page;

  /// Constructeur prenant une `page` comme paramètre pour la transition.
  SlideTransition1(this.page)
      : super(
          // Construit la page avec une animation de transition et de retour.
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          // Construit la transition avec une courbe d'accélération/décélération personnalisée.
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            // Applique une transition de glissement horizontal à la page.
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(animation),
              child: page,
            );
          },
        );
}
