import 'package:flutter/material.dart';
import '../../models/etudiant.dart';
import '../../services/api_service.dart';

class ListeEtudiantsPage extends StatefulWidget {
  const ListeEtudiantsPage({Key? key}) : super(key: key);

  @override
  State<ListeEtudiantsPage> createState() => _ListeEtudiantsPageState();
}

class _ListeEtudiantsPageState extends State<ListeEtudiantsPage> {
  late Future<List<Etudiant>> _etudiantsFuture;

  @override
  void initState() {
    super.initState();
    _etudiantsFuture = ApiService.fetchEtudiants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Étudiants')),
      body: FutureBuilder<List<Etudiant>>(
        future: _etudiantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun étudiant trouvé'));
          }

          final etudiants = snapshot.data!;
          return ListView.builder(
            itemCount: etudiants.length,
            itemBuilder: (context, index) {
              final e = etudiants[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text('${e.nom} ${e.prenom}'),
                  subtitle: Text('${e.classe} - ${e.email}'),
                  trailing: Text(e.matricule),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
