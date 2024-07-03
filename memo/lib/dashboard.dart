import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'views/deck_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: screenSize.width * 0.8, // Use 80% of the screen width
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search here...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: const EdgeInsets.all(0),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Text(
                'Memo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: Text('Learn'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeckList()),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.check_box),
              title: Text('To Do'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendar'),
            ),
            const ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Statistics'),
            ),
            const ListTile(
              leading: Icon(Icons.auto_awesome),
              title: Text('Memo Ai'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  OverviewCard(
                      const Icon(Icons.book, color: Colors.pink, size: 24),
                      title: 'Flashcards Created',
                      value: '180',
                      color: Colors.pink[100]!, icon: const Icon(Icons.book, color: Colors.pink, size: 24,),),
                  const SizedBox(width: 16),
                  OverviewCard(
                      const Icon(Icons.check_box, color: Colors.orange),
                      title: 'Tasks completed',
                      value: '40',
                      color: Colors.orange[100]!, icon:  const Icon(Icons.check_box, color: Colors.orange, size: 24,),),
                  const SizedBox(width: 16),
                  OverviewCard(
                      const Icon(Icons.timer, color: Colors.green),
                      title: 'Hours Studied',
                      value: '5',
                      color: Colors.green[100]!, icon: const Icon(Icons.timer, color: Colors.green, size: 24,),),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Monday, 27th May 2023',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.book, color: Colors.white),
                                ),
                                title: Text('Biology'),
                                subtitle: Text('01:00 PM - 02:00 PM'),
                              ),
                              const ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.book, color: Colors.white),
                                ),
                                title: Text('Maths'),
                                subtitle: Text('02:00 PM - 03:00 PM'),
                              ),
                              const ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.book, color: Colors.white),
                                ),
                                title: Text('English'),
                                subtitle: Text('03:00 PM - 04:00 PM'),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('View Calendar'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Checkbox(
                                    value: true, onChanged: (value) {}),
                                title: const Text('Dashboard Builder'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Checkbox(
                                    value: true, onChanged: (value) {}),
                                title: const Text('Mobile App Design'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Checkbox(
                                    value: false, onChanged: (value) {}),
                                title: const Text('Illustrations'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Checkbox(
                                    value: false, onChanged: (value) {}),
                                title: const Text('Promotional LP'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink),
                                child: const Text('+ New'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Study Score',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '97.5',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Recent',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading:
                                    Icon(Icons.language, color: Colors.pink),
                                title: Text('Spanish'),
                                trailing: Text('+50'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.book, color: Colors.pink),
                                title: Text('English'),
                                trailing: Text('+20'),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading:
                                    Icon(Icons.calculate, color: Colors.pink),
                                title: Text('Maths'),
                                trailing: Text('+27.5'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Streak',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent: 0.75,
                                  center: const Text(
                                    "15",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.pink,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Center(
                                child: Text('Keep it up, Manav!'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(57),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Row(

                            children: [
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('New Tasks',
                                        style: TextStyle(fontSize: 16)),
                                    Text('154', style: TextStyle(fontSize: 24)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('New Events',
                                        style: TextStyle(fontSize: 16)),
                                    Text('6', style: TextStyle(fontSize: 24)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text('Total Minutes',
                                        style: TextStyle(fontSize: 16)),
                                    Text('540', style: TextStyle(fontSize: 24)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text('Focus Timer',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Focus', style: TextStyle(fontSize: 16)),
                                  Text('30:00', style: TextStyle(fontSize: 24)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Break', style: TextStyle(fontSize: 16)),
                                  Text('5:00', style: TextStyle(fontSize: 24)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Rest', style: TextStyle(fontSize: 16)),
                                  Text('10:00', style: TextStyle(fontSize: 24)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink),
                            child: const Text('Start'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Icon icon;

  const OverviewCard(Icon Icon, {super.key, required this.title, required this.value, required this.color, required, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const Padding(padding: const EdgeInsets.all(8)),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}