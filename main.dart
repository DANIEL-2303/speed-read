import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa el paquete para abrir URLs.
import 'package:provider/provider.dart';
import 'niveles.dart';
import 'prueba_PAP.dart';

void main() {
  runApp(MyApp()); // Inicia la aplicación.
}

// Clase para manejar el tema
// Clase para manejar el tema
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getThemeData() {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Mi Aplicación',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.getThemeData(),
            initialRoute: '/',
            routes: {
              '/': (context) => AuthScreen(),
              '/register': (context) => RegisterScreen(),
            },
          );
        },
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false;
  bool isLoggedIn = false;
  String? registeredEmail;
  String? registeredPassword;

  // URL a la que se redigirá al presionar la imagen
  final Uri _url = Uri.parse('https://www.uts.edu.co/sitio/portal-academico/');

  // Función para abrir la URL usando url_launcher.
  Future<void> _launchURL() async {
  final String url = 'https://www.uts.edu.co/sitio/portal-academico/';
  if (!await launch(url)) {
    throw 'No se pudo abrir $url';
  }
}

  void register() async {
    final result = await Navigator.pushNamed(context, '/register');
    if (result != null && result is Map<String, String>) {
      setState(() {
        isRegistered = true;
        registeredEmail = result['email'];
        registeredPassword = result['password'];
      });
    }
  }

  void login() {
    if (isRegistered) {
      final enteredEmail = emailController.text;
      final enteredPassword = passwordController.text;

      if (enteredEmail == registeredEmail && enteredPassword == registeredPassword) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text(
                  'Credenciales incorrectas. Verifica tu correo y contraseña.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('Debes registrarte antes de iniciar sesión.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return MyHomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Inicio de Sesión o Registro'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // La imagen se envuelve en un GestureDetector para que al tocarla se abra la URL.
              GestureDetector(
                onTap: _launchURL,
                child: Image.asset('img/proyecto.png'),
              ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                ),
              ),
              Container(
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: login,
                child: Text('Iniciar Sesión'),
              ),
              TextButton(
                onPressed: register,
                child: Text('¿No tienes una cuenta? Regístrate aquí.'),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController registerEmailController = TextEditingController();
    TextEditingController registerPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                child: Image.asset('img/proyecto.png'),
              ),
              SizedBox(height: 20),
            TextField(
              controller: registerEmailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: registerPasswordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                final registerEmail = registerEmailController.text;
                final registerPassword = registerPasswordController.text;
                final result = {'email': registerEmail, 'password': registerPassword};
                Navigator.pop(context, result);
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PaginaInicio(),
    PaginaRacha(),
    PaginaEstadi(),
    PaginaConfi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Speed Read')),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 25.0,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedItemColor: Colors.black, // Color para ícono y texto seleccionado
        unselectedItemColor: Colors.red, // Color para ícono y texto no seleccionado
        selectedLabelStyle: TextStyle(color: Colors.black), // Estilo de texto seleccionado
        unselectedLabelStyle: TextStyle(color: Colors.red), // Estilo de texto no seleccionado
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Racha'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Estadistica'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuracion'),

        ],
      ),
    );
  }
}

// 🎯 Página con input 1
class PaginaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[700],
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Título con fondo negro redondeado
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '¡HOLA!\n¿QUÉ MODO ELIGREMOS?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              SizedBox(height: 20),
              
              // Botón para PAP (Palabra a Palabra)
              GestureDetector(
                onTap: () {
                  try {
                    print("Botón PAP tocado");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PathLevelsScreen()),
                    );
                  } catch (e) {
                    print("Error en navegación: $e");
                    // You could also show a dialog with the error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error de navegación'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: _buildModeCard(
                  icon: Icons.edit,
                  title: 'P A P',
                  description: 'Afronta el reto de analizar y comprender cada palabra, una a una.',
                ),
              ),
              
              SizedBox(height: 20),
              
              _buildModeCard(
                icon: Icons.grid_view,
                title: 'BLOQUE',
                description: 'Sumérgete en la comprensión integral del texto, de principio a fin.',
              ),
              
              SizedBox(height: 20),
              
              _buildModeCard(
                icon: Icons.remove_red_eye,
                title: 'SEGUIMIENTO OCULAR',
                description: 'Sigue el texto con precisión, una mirada a la vez.',
              ),
              
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, size: 60, color: Colors.black),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// Modificación de MyHomePage para asegurar que todo el fondo sea rojo
class MyHomePage2 extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PaginaInicio(),
    PaginaRacha(),
    PaginaEstadi(),
    PaginaConfi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar para tener más espacio
      body: Container(
        // Este container cubre toda la pantalla con color rojo
        color: Colors.red[700],
        child: SafeArea(
          // SafeArea evita que el contenido se oculte bajo la barra de estado
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 28.0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // Fondo blanco para el menú inferior
        elevation: 8, // Sombra para destacar el menú
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Racha'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Estadística'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuración'),
        ],
      ),
    );
  }
}

// 🎯 Página con input 2
class PaginaRacha extends StatefulWidget {

  @override
  _PaginaRachaState createState() => _PaginaRachaState();
}

class _PaginaRachaState extends State<PaginaRacha> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Página Racha', style: TextStyle(fontSize: 24)),
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Buscar...'),
          ),
        ],
      ),
    );
  }
}

// 🎯 Página con input 3
class PaginaEstadi extends StatefulWidget {
  @override
  _PaginaEstadiState createState() => _PaginaEstadiState();
}

class _PaginaEstadiState extends State<PaginaEstadi> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Página Estadisca', style: TextStyle(fontSize: 24)),
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Nombre de usuario'),
          ),
        ],
      ),
    );
  }
}
// 🎯 Página con input 4
class PaginaConfi extends StatefulWidget {
  @override
  _PaginaConfiState createState() => _PaginaConfiState();
}

class _PaginaConfiState extends State<PaginaConfi> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Página Perfil', style: TextStyle(fontSize: 24)),
           SwitchListTile(
            title: Text('Modo Oscuro'),
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (bool value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}

