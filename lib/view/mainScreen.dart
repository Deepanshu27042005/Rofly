import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:roflly/controler/fetchMeme.dart';
import 'package:roflly/controler/saveMyData.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imgUrl = "";
  int memeNo = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getInitMemeNo();
    updateMeme();
  }

  Future<void> _getInitMemeNo() async {
    int? storedNo = await SaveData.fetchData() ?? 0;
    setState(() {
      memeNo = storedNo;
    });
  }

  Future<void> updateMeme() async {
    String getImgUrl = await fetchMeme().fetchNewMeme();
    setState(() {
      imgUrl = getImgUrl;
      isLoading = false;
    });
  }

  Future<void> _onNextMeme() async {
    setState(() {
      memeNo++;
      isLoading = true;
    });

    await SaveData.saveData(memeNo);
    await updateMeme();
  }

  @override
  Widget build(BuildContext context) {
    double progress = memeNo / 500;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Meme counter with emoji
              Text(
                "😂 Meme #$memeNo",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "🎯 Target 500 memes",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),

              const SizedBox(height: 15),
              // progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress > 1 ? 1 : progress,
                    minHeight: 10,
                    backgroundColor: Colors.white24,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Meme Card with glass effect
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      _onNextMeme(); // swipe = new meme
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 320,
                          height: 400,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white30,
                              width: 1,
                            ),
                          ),
                          child: isLoading
                              ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imgUrl,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                size: 120,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Fun Button
              ElevatedButton.icon(
                onPressed: _onNextMeme,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text(
                  "Next Meme!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Made with ❤️ by Deepanshu",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
