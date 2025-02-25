import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E21),
              Color(0xFF1D1E33),
              Color(0xFF2D2E42),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background elements
            Positioned.fill(
              child: CustomPaint(
                painter: _CyberBackgroundPainter(),
              ),
            ),

            Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.blueAccent.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlue],
                            stops: [0.3, 0.7],
                          ).createShader(bounds),
                          child: const Text(
                            'WELCOME',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Access your account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Google Login Button
                        _buildCyberButton(
                          context,
                          icon: Icons.g_translate,
                          label: 'Continue with Google',
                          onPressed: _handleGoogleLogin,
                        ),
                        const SizedBox(height: 25),

                        // Divider
                        _buildCyberDivider(),
                        const SizedBox(height: 25),

                        // Alternative Options
                        Text(
                          'Other Access Methods',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCyberIconButton(
                              icon: Icons.email,
                              color: Colors.blueAccent,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            _buildCyberIconButton(
                              icon: Icons.phone,
                              color: Colors.cyanAccent,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCyberButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Reduced padding
            constraints: const BoxConstraints(minWidth: 200), // Add minimum width
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 24), // Reduced icon size
                const SizedBox(width: 12),
                Flexible( // Add Flexible widget
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15, // Slightly reduced font size
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                    overflow: TextOverflow.ellipsis, // Add overflow handling
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildCyberIconButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Icon(icon, color: color, size: 28),
        ),
      ),
    );
  }

  Widget _buildCyberDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.blueGrey.withOpacity(0.4),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.blueGrey.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.blueGrey.withOpacity(0.4),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  void _handleGoogleLogin() async {
    final user = await AuthService().signInWithGoogle();
    if (user == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.amber),
              const SizedBox(width: 10),
              Text(
                'Authentication Failed',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _CyberBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Draw background hex pattern
    final hexSize = 80.0;
    final rows = (size.height / hexSize).ceil();
    final cols = (size.width / hexSize).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final x = i * hexSize;
        final y = j * hexSize;
        final path = Path()
          ..moveTo(x + hexSize/2, y)
          ..lineTo(x + hexSize, y + hexSize/4)
          ..lineTo(x + hexSize, y + 3*hexSize/4)
          ..lineTo(x + hexSize/2, y + hexSize)
          ..lineTo(x, y + 3*hexSize/4)
          ..lineTo(x, y + hexSize/4)
          ..close();
        canvas.drawPath(path, paint);
      }
    }

    // Draw glowing lines
    final linePaint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final linePath = Path()
      ..moveTo(0, size.height * 0.3)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.4,
          size.width * 0.6, size.height * 0.35)
      ..quadraticBezierTo(
          size.width * 0.8, size.height * 0.3,
          size.width, size.height * 0.4);

    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}