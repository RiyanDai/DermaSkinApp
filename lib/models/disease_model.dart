// Buat file baru di models/skin_disease.dart
import 'package:flutter/material.dart';

class SkinDisease {
  final String name;
  final String scientificName;
  final String description;
  final String prevention;
  final String treatment;
  final Color color;

  SkinDisease({
    required this.name,
    required this.scientificName,
    required this.description,
    required this.prevention,
    required this.treatment,
    required this.color,
  });

  static List<SkinDisease> getAll() {
    return [
      SkinDisease(
        name: 'Panu',
        scientificName: 'Tinea Versicolor',
        description: 'Infeksi jamur yang menyebabkan bercak berskala pada kulit dengan berbagai warna.',
        prevention: '• Menjaga kebersihan kulit\n• Menghindari pakaian ketat\n• Mengeringkan tubuh dengan baik setelah berkeringat\n• Hindari berbagi handuk atau pakaian pribadi',
        treatment: '• Sampo anti-jamur (selenium sulfide)\n• Krim anti-jamur topikal (ketoconazole, clotrimazole)\n• Obat anti-jamur oral untuk kasus parah\n• Mandi dengan sabun sulfur',
        color: Colors.amber,
      ),
      SkinDisease(
        name: 'Psoriasis',
        scientificName: 'Psoriasis Vulgaris',
        description: 'Penyakit autoimun kronis yang menyebabkan pertumbuhan sel kulit berlebih, menghasilkan plak merah tebal dengan sisik perak.',
        prevention: '• Hindari pemicu seperti stres\n• Gunakan pelembab secara teratur\n• Hindari trauma pada kulit\n• Batasi konsumsi alkohol\n• Berhenti merokok',
        treatment: '• Kortikosteroid topikal\n• Fototerapi (terapi cahaya)\n• Obat oral imunosupresan\n• Obat biologis untuk kasus berat\n• Perawatan dengan vitamin D3 topikal',
        color: Colors.redAccent,
      ),
      SkinDisease(
        name: 'Kutil',
        scientificName: 'Verruca Vulgaris',
        description: 'Pertumbuhan kecil pada kulit yang disebabkan oleh infeksi human papillomavirus (HPV), biasanya tidak berbahaya tetapi dapat menyebar.',
        prevention: '• Hindari kontak langsung dengan kutil\n• Jangan berbagi handuk atau alat pribadi\n• Jaga kebersihan tangan\n• Hindari menggaruk atau melukai kutil\n• Gunakan sandal di area kolam renang atau kamar mandi umum',
        treatment: '• Cryotherapy (pembekuan)\n• Asam salisilat topikal\n• Terapi laser\n• Electrocautery (pembakaran)\n• Imiquimod (peningkat respons imun)',
        color: Colors.green,
      ),
    ];
  }
}