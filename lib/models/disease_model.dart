// Buat file baru di models/skin_disease.dart
import 'package:flutter/material.dart';

class SkinDisease {
  final String name;
  final String scientificName;
  final String description;
  final String prevention;
  final String treatment;
  final Color color;
  final String imagePath;

  SkinDisease({
    required this.name,
    required this.scientificName,
    required this.description,
    required this.prevention,
    required this.treatment,
    required this.color,
    required this.imagePath,
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
        imagePath: 'assets/panu.png',
      ),
      SkinDisease(
        name: 'Psoriasis',
        scientificName: 'Psoriasis Vulgaris',
        description: 'Penyakit autoimun kronis yang menyebabkan pertumbuhan sel kulit berlebih, menghasilkan plak merah tebal dengan sisik perak.',
        prevention: '• Hindari pemicu seperti stres\n• Gunakan pelembab secara teratur\n• Hindari trauma pada kulit\n• Batasi konsumsi alkohol\n• Berhenti merokok',
        treatment: '• Kortikosteroid topikal\n• Fototerapi (terapi cahaya)\n• Obat oral imunosupresan\n• Obat biologis untuk kasus berat\n• Perawatan dengan vitamin D3 topikal',
        color: Colors.redAccent,
        imagePath: 'assets/psoriasis.png',
      ),
      SkinDisease(
        name: 'Kutil',
        scientificName: 'Verruca Vulgaris',
        description: 'Pertumbuhan kecil pada kulit yang disebabkan oleh infeksi human papillomavirus (HPV), biasanya tidak berbahaya tetapi dapat menyebar.',
        prevention: '• Hindari kontak langsung dengan kutil\n• Jangan berbagi handuk atau alat pribadi\n• Jaga kebersihan tangan\n• Hindari menggaruk atau melukai kutil\n• Gunakan sandal di area kolam renang atau kamar mandi umum',
        treatment: '• Cryotherapy (pembekuan)\n• Asam salisilat topikal\n• Terapi laser\n• Electrocautery (pembakaran)\n• Imiquimod (peningkat respons imun)',
        color: Colors.green,
        imagePath: 'assets/kutil.png',
      ),
      SkinDisease(
        name: 'Melanoma',
        scientificName: 'Melanoma Malignum',
        description: 'Kanker kulit yang berkembang dari sel-sel penghasil pigmen (melanosit). Merupakan jenis kanker kulit yang paling berbahaya dan dapat menyebar ke organ lain jika tidak ditangani segera.',
        prevention: '• Lindungi kulit dari paparan sinar UV berlebih\n• Gunakan tabir surya SPF 30+ secara teratur\n• Hindari tanning bed\n• Periksa kulit secara berkala untuk perubahan\n• Kenakan pakaian pelindung saat beraktivitas di luar\n• Hindari paparan sinar matahari pada jam 10 pagi - 4 sore',
        treatment: '• Pembedahan untuk mengangkat tumor dan jaringan sekitarnya\n• Terapi imunoterapi\n• Terapi target\n• Kemoterapi\n• Radioterapi\n• Terapi biologis\n• Pemeriksaan berkala untuk deteksi dini',
        color: Colors.deepPurple,
        imagePath: 'assets/melanoma.png',
      ),
    ];
  }
}