import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // To add Icon Image
  final Icon cross = const Icon(Icons.cancel, size: 80);
  final Icon circle = const Icon(Icons.circle, size: 80);
  final Icon edit = const Icon(Icons.edit, size: 80);

  bool isCross = true;
  late String message;
  late List<String> gameState;

  // Initialize Box with Empty value
  @override
  void initState() {
    gameState = List.filled(9, "empty"); // ✅ fixed list initialization
    message = "";
    super.initState();
  }

  // To play Game
  void playGame(int index) {
    if (gameState[index] == "empty") {
      setState(() {
        gameState[index] = isCross ? "cross" : "circle";
        isCross = !isCross;
        checkWin();
      });
    }
  }

  // Reset Game
  void resetGame() {
    setState(() {
      gameState = List.filled(9, "empty");
      message = "";
      isCross = true;
    });
  }

  // To get Icon image
  Icon getIcon(String title) {
    switch (title) {
      case "empty":
        return edit;
      case "cross":
        return cross;
      case "circle":
        return circle;
      default:
        return const Icon(Icons.help_outline, size: 80); // ✅ added default
    }
  }

  // To check for winning
  void checkWin() {
    // Winning combinations
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      String a = gameState[pattern[0]];
      String b = gameState[pattern[1]];
      String c = gameState[pattern[2]];

      if (a != "empty" && a == b && b == c) {
        setState(() {
          message = "$a wins!";
        });
        return;
      }
    }

    if (!gameState.contains("empty")) {
      setState(() {
        message = "Game Draw";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic Tac Toe")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10), // ✅ moved padding here
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: gameState.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 100,
                  height: 100,
                  child: MaterialButton(
                    onPressed: () => playGame(i),
                    child: getIcon(gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            color: Colors.blue[800],
            minWidth: 200,
            onPressed: resetGame,
            child: const Text(
              "Reset Game",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Build By Amrit Marasini"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
