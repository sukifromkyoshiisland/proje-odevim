import 'package:flutter/material.dart';

//SEPET LİSTESİ
List<Bicak> sepetimiz = [];

void main() {
  runApp(const BenimUygulamam());
}

class BenimUygulamam extends StatelessWidget {
  const BenimUygulamam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hocho Hub Katalog',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFBF9F5),
        primaryColor: const Color(0xFF1E1B18),
      ),
      home: const AnaSayfa(),
    );
  }
}

// =========================================================================
// VERİ MODELİ SINIFI
// =========================================================================
class Bicak {
  final String isim;
  final String seri;
  final String tur;
  final String celik;
  final int sertlik;
  final String resimYolu; 
  final int fiyat;        
  final String aciklama;  

  Bicak({
    required this.isim,
    required this.seri,
    required this.tur,
    required this.celik,
    required this.sertlik,
    required this.resimYolu,
    required this.fiyat,
    required this.aciklama,
  });
}

// BIÇAKLARIN LİSTESİ
List<Bicak> bicakListesi = [
  Bicak(
    isim: "Sakai Takayuki",
    seri: "Damasco Uzumaki",
    tur: "Santoku Knife",
    celik: "VG-10 Core 33-Layers",
    sertlik: 60,
    resimYolu: "assets/images/bican2.jpg",
    fiyat: 4750,
    aciklama: "Sakai bölgesinin 600 yıllık demircilik mirasıyla dövülen bu Santoku, mutfaktaki tüm kesim işlemlerinizde profesyonel bir deneyim sunar. 33 katmanlı hakiki Şam çeliği (Damascus) deseni, bıçağa hem üstün bir esneklik hem de asil bir müze görünümü kazandırır.",
  ),
  Bicak(
    isim: "Masamoto Sohonten",
    seri: "KK Shirogami Hon Kasumi",
    tur: "Yanagiba (Sashimi)",
    celik: "White Steel No.2",
    sertlik: 62,
    resimYolu: "assets/images/bican1.jpg",
    fiyat: 8900,
    aciklama: "Geleneksel Japon mutfağının zirvesi olan Yanagiba, sashimi ve suşi kesimlerinde milimetrik hassasiyet için tek taraflı bilenmiştir. Saf Shirogami (Beyaz Çelik) çekirdeği, zanaatkarlar tarafından elde dövülerek jilet keskinliğine ulaştırılmıştır.",
  ),
  Bicak(
    isim: "Yu Kurosaki",
    seri: "Senko Ei Shizuku",
    tur: "Bunka Utility",
    celik: "SG2 (R2) Powder Steel",
    sertlik: 63,
    resimYolu: "assets/images/bican3.jpg",
    fiyat: 6400,
    aciklama: "Echizen bölgesinin ödüllü genç ustası Yu Kurosaki tarafından tasarlanan bu Bunka, çekiç dövme (Tsuchime) tekniğiyle yapılmış su damlası desenlerine sahiptir. SG2 toz çeliği sayesinde keskinliğini aylarca ilk günkü gibi korur.",
  ),
];

// =========================================================================
// 1. EKRAN: ANA SAYFA WIDGET'I
// =========================================================================
class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'HOCHO HUB',
          style: TextStyle(color: Color(0xFF1E1B18), fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5),
        ),
        actions: [
          // Sağ üstteki sepet butonu
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF1E1B18), size: 24),
            onPressed: () {
              // Sepet sayfasına geçiş
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SepetSayfasi()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        // Buradaki padding ayarlarını kafama göre verdim
        padding: const EdgeInsets.only(top: 12, left: 18, right: 14, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Japon Bıçakları Kataloğu',
              style: TextStyle(color: Color(0xFF1E1B18), fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Mutfaktaki yeni dostunuzla tanışın',
              style: TextStyle(color: Colors.grey, fontSize: 13, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            // İkişerli liste tasarladığım yer (GridView)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.74, 
                ),
                itemCount: bicakListesi.length,
                itemBuilder: (context, index) {
                  final bicak = bicakListesi[index];
                  return GestureDetector(
                    onTap: () {
                      // Karta tıklanınca detay ekranına veriyi gönderiyor
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetaySayfasi(bicak: bicak),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1B18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.asset(
                                bicak.resimYolu,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bicak.isim,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bicak.tur,
                                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                                    ),
                                    Text(
                                      "${bicak.fiyat} TL",
                                      style: const TextStyle(color: Color(0xFFE6C687), fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// 2. EKRAN: BIÇAK DETAY SAYFASI WIDGET'I
// =========================================================================
class DetaySayfasi extends StatelessWidget {
  final Bicak bicak;
  const DetaySayfasi({super.key, required this.bicak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E1B18), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Ürün Detayı', style: TextStyle(color: Color(0xFF1E1B18), fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              bicak.resimYolu,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bicak.isim, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1B18))),
                          Text(bicak.seri, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      Text(
                        "${bicak.fiyat} TL",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1B18)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Teknik özelliklerin durduğu alan
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1B18).withOpacity(0.04),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _ozellikSatiri("Bıçak Tipi", bicak.tur),
                        _ozellikSatiri("Çelik Türü", bicak.celik),
                        _ozellikSatiri("Sertlik Derecesi", "${bicak.sertlik} HRC"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Özellikler Kısmı
                  const Text(
                    "Bıçak Özellikleri",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E1B18)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bicak.aciklama,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF555555), height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  // SEPETE EKLEME BUTONU
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E1B18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), 
                      ),
                      onPressed: () {
                        sepetimiz.add(bicak); // Listeye ekliyor
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${bicak.isim} sepete eklendi!'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text('SEPETE EKLE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ozellikSatiri(String baslik, String deger) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(baslik, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Text(deger, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}

// =========================================================================
// 3. EKRAN: SEPETİM SAYFASI WIDGET'I (SİLME ÖZELLİKLİ)
// =========================================================================
class SepetSayfasi extends StatefulWidget {
  const SepetSayfasi({super.key});

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E1B18), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Sepetim', style: TextStyle(color: Color(0xFF1E1B18), fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: sepetimiz.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 70, color: Colors.grey.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        const Text('Sepetiniz Boş', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Henüz bir bıçak eklemediniz.', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: sepetimiz.length,
                    itemBuilder: (context, index) {
                      final eleman = sepetimiz[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Image.asset(eleman.resimYolu, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(eleman.isim, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          subtitle: Text("${eleman.tur} - ${eleman.fiyat} TL", style: const TextStyle(fontSize: 12)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              // Elemanı silip sayfayı anlık güncelliyor
                              setState(() {
                                sepetimiz.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // SATIN ALMA BUTONU (CHECKOUT)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1B18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sipariş simülasyonu başarılı!')),
                  );
                },
                child: const Text('CHECKOUT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}