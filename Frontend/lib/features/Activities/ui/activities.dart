// activities_screen.dart
import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  final List<Map<String, dynamic>> activities = [
    {
      'title': 'Breathing',
      'icon': Icons.air,
      'color': Colors.blue.shade100,
      'route': '/breathing'
    },
    {
      'title': 'Affirmations',
      'icon': Icons.favorite,
      'color': Colors.pink.shade100,
      'route': '/affirmations'
    },
    {
      'title': 'Quotes',
      'icon': Icons.format_quote,
      'color': Colors.purple.shade100,
      'route': '/quotes'
    },
    {
      'title': 'Sounds',
      'icon': Icons.music_note,
      'color': Colors.green.shade100,
      'route': '/sounds'
    },
    {
      'title': 'Notepad',
      'icon': Icons.edit_note,
      'color': Colors.orange.shade100,
      'route': '/notepad'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Activities',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What would you like to do today?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ActivityCard(
                        title: activities[index]['title'],
                        icon: activities[index]['icon'],
                        color: activities[index]['color'],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            activities[index]['route'],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.black87,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// breathing_screen.dart
class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _seconds = 0;
  bool _isRunning = false;
  String _phase = "Prepare";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() {
        setState(() {});
      });
  }

  void _startBreathing() {
    setState(() {
      _isRunning = true;
      _seconds = 0;
      _phase = "Inhale";
    });
    _controller.repeat(reverse: true);
    _updateTimer();
  }

  void _updateTimer() {
    if (!_isRunning) return;
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _seconds++;
        if (_seconds % 4 == 0) {
          _phase = _phase == "Inhale" ? "Exhale" : "Inhale";
        }
      });
      _updateTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercise'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
              child: Center(
                child: Container(
                  width: 150 * _controller.value,
                  height: 150 * _controller.value,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _phase,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            Text(
              '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40),
            if (!_isRunning)
              ElevatedButton(
                onPressed: _startBreathing,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// quotes_screen.dart
class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final PageController _pageController = PageController();
  final List<Map<String, String>> quotes = [
    {
      'quote':
          'You are stronger than you know. Braver than you believe. And more capable than you can imagine.',
      'author': 'Unknown'
    },
    {
      'quote':
          'The only way out is through. Keep going, keep growing, keep glowing.',
      'author': 'Robert Frost'
    },
    {
      'quote':
          'Your mental health is a priority. Your happiness is essential. Your self-care is a necessity.',
      'author': 'Unknown'
    },
    // Add more quotes here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple.withOpacity(0.6),
                  Colors.blue.withOpacity(0.6),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quotes[index]['quote']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '- ${quotes[index]['author']}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
