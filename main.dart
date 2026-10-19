import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

/// Model data rute KRL
class RuteKRL {
  final String namaRute;
  final int tarif;
  final double waktuTempuh; // dalam menit
  final String pembuatData;
  final bool isFavorit;

  const RuteKRL({
    required this.namaRute,
    required this.tarif,
    required this.waktuTempuh,
    required this.pembuatData,
    required this.isFavorit,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LayarUtama(),
    );
  }
}

class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

  @override
  Widget build(BuildContext context) {
    const ruteHarian = RuteKRL(
      namaRute: 'Duri ➔ Rawa Buaya',
      tarif: 3000,
      waktuTempuh: 25.0,
      pembuatData: 'Jaquinta Rahmadias Kusuma - 202432001',
      isFavorit: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Commuter Assistant'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.train, size: 40, color: Colors.teal),
                const SizedBox(height: 8),
                const Text(
                  'Rute Harian Saya',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                const RuteCard(rute: ruteHarian),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    debugPrint('Tombol Diklik');
                  },
                  child: const Text('Cek Rute'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom widget kartu rute
class RuteCard extends StatelessWidget {
  final RuteKRL rute;

  const RuteCard({super.key, required this.rute});

  String _rupiah(int v) {
    final s = v.toString();
    final b = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
      b.write(s[i]);
    }
    return 'Rp $b';
  }

  Widget _info(IconData ikon, String teks) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ikon, size: 20, color: Colors.teal),
        const SizedBox(width: 6),
        Text(teks),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.route, color: Colors.teal),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    rute.namaRute,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  rute.isFavorit ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final tarif = _info(Icons.payments, _rupiah(rute.tarif));
                final waktu =
                    _info(Icons.schedule, '${rute.waktuTempuh} menit');
                if (constraints.maxWidth < 280) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [tarif, const SizedBox(height: 8), waktu],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [tarif, waktu],
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person, size: 20, color: Colors.teal),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    rute.pembuatData,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}