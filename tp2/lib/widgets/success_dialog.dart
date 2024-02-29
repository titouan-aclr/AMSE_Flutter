import 'package:flutter/material.dart';
import 'package:tp2/widgets/puzzle_grid.dart';

/*****************/
/* WIDGET CLASS  */
/*****************/
class SuccessDialog extends StatelessWidget {
  final int score; //-> score à afficher
  final String chrono; //-> temps à afficher
  final Function resetGameCallback; //-> fonction de réinitialisation du jeu
  const SuccessDialog(
      {super.key,
      required this.score,
      required this.chrono,
      required this.resetGameCallback});

  /// CONSTRUCTION DE L'UI
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Félicitations !",
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('images/good_job_1.gif', height: 200)),
            const SizedBox(height: 20),
            // affichage du détail du score : pénalités de déplacement
            Text("Pénalités de déplacement : ${SCORE_INITIAL - score} points",
                style: const TextStyle(fontSize: 10)),
            const SizedBox(height: 5),
            // affichage du détail du score : pénalités de temps
            Text(
                "Pénalités de temps : ${int.parse(chrono.substring(0, 2)) * 2} points",
                style: const TextStyle(fontSize: 10)),
            const SizedBox(height: 5),
            // affichage du score total
            Text("Score : $score", style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            // affichage du temps chonométré
            Text("Temps : $chrono", style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // bouton de retour à la liste d'accueil
                OutlinedButton.icon(
                  icon: const Icon(Icons.exit_to_app_rounded),
                  label: const Text("Quitter", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                // bouton de réinitialisation du jeu
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.autorenew_rounded),
                  label: const Text("Rejouer", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                    resetGameCallback();
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// FONCTIONS DE CALCUL DES DETAILS DE SCORE
  // calcul du détail des pénalités de déplacements
  int calculateMovementPenalities() {
    return SCORE_INITIAL - score;
  }

  // calcul du détail des pénalités de temps
  int calculateTimePenalities() {
    int minutes = int.parse(chrono.substring(0, 2));
    return minutes * 2;
  }
}
