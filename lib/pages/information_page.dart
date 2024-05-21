import 'package:bitirme_projesi/routes.dart';
import 'package:bitirme_projesi/services/cloud_database/firebase_cloud_user_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstTextController = TextEditingController();
  late DateTime _secondText = DateTime.now();
  final TextEditingController _secondTextController = TextEditingController();
  final TextEditingController _thirdTextController = TextEditingController();

  final FirebaseCloudStorage _firestore = FirebaseCloudStorage();

  @override
  void initState() {
    super.initState();
    _secondTextController.text = DateFormat("dd-MM-yyyy").format(_secondText);
  }

  @override
  void dispose() {
    _firstTextController.dispose();
    _secondTextController.dispose();
    _thirdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 20), // Kenarlara boşluk ekleyin
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

        child: GestureDetector(
          onTap: () {
            // Boş bir alana tıklandığında uyarıları kaldır
            FocusScope.of(context).unfocus();
          },
          //overflow engellemek için
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/background_image.png"),
                    alignment: Alignment.center,
                    fit: BoxFit.contain)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  50, 200, 20, 50), //her taraftan bırakılan mesafe ,)
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Daha önce hastalık geçirdiniz mi?",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left),
                        const SizedBox(
                            height: 7), //text ve textformfield arası mesafe
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Times New Roman', //input yazı rengi
                          ),
                          controller: _firstTextController,
                          keyboardType: TextInputType.text, //inputun tipi
                          decoration: const InputDecoration(
                              //input kutucuğu özelleştirme
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 50.0), //kenarlık rengi ve kalınlığı
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10)), // input kutucuğunun köşeli olmasını sağlar
                              ),
                              //kutucuğa tıklandığındaki görünüm
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFCC4646)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true, //kutucuk doldurulması için onay
                              fillColor: Color.fromRGBO(255, 255, 255,
                                  0.7), // input kutucuğunun arka plan rengi
                              contentPadding: EdgeInsets.symmetric(
                                //input kutucuğunun yüksekliği
                                vertical: 5.0,
                                horizontal: 10,
                              ),
                              hintText: '  Evet/Hayır'),
                          validator: (value) {
                            //input girilip girilmediğini kontrol eder
                            if (value == null || value.isEmpty) {
                              return 'Lütfen yanıtlayınız..'; //girilmediyse bu mesaj iletilir
                            }
                            return null; //e-mail geçerli
                          },
                        ),
                        const SizedBox(
                            height: 35), //textboxlar arasındaki mesafe
                        const Text("En son ne zaman kan verdiniz?",
                            style: TextStyle(
                              fontSize: 25, //yazı boyutu
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left),
                        const SizedBox(
                            height: 5), //text ve textformfield arası mesafe
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Times New Roman',
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          controller: _secondTextController,
                          decoration: const InputDecoration(
                              //input kutucuğu özelleştirme
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 50.0), //kenarlık rengi ve kalınlığı
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10)), //input kutucuğunun köşeli olması sağlanır
                              ),
                              //kutucuğa tıklandığındaki görünüm
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFCC4646)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255,
                                  0.7), //input kutucuğunun arka plan rengi
                              contentPadding: EdgeInsets.symmetric(
                                //input kutucuğunun yüksekliği
                                vertical: 5.0,
                                horizontal: 10,
                              ),
                              hintText: '  GG/AA/YY'),
                          validator: (value) {
                            //input girilip girilmediğini kontrol eder
                            if (value == null || value.isEmpty) {
                              return 'Lütfen yanıtlayınız..'; //girilmediyse bu mesaj iletilir
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                            height: 35), //textboxlar arasındaki mesafe
                        const Text("Kilonuzu giriniz",
                            style: TextStyle(
                              fontSize: 25, //yazı boyutu
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left),
                        const SizedBox(
                            height: 5), //text ve textformfield arası mesafe
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Times New Roman',
                          ),
                          controller: _thirdTextController,
                          decoration: const InputDecoration(
                            //input kutucuğu özelleştirme
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 50.0), //kenarlık rengi ve kalınlığı
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10)), //input kutucuğunun köşeli olması sağlanır
                            ),
                            //kutucuğa tıklandığındaki görünüm
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFCC4646)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            filled: true,
                            fillColor: Colors
                                .white, //input kutucuğunun arka plan rengi
                            contentPadding: EdgeInsets.symmetric(
                              //input kutucuğunun yüksekliği
                              vertical: 5.0,
                              horizontal: 10,
                            ),
                            hintText: '  50 (kg)',
                          ),
                          validator: (value) {
                            //input girilip girilmediğini kontrol eder
                            if (value == null || value.isEmpty) {
                              return 'Lütfen yanıtlayınız..'; //girilmediyse bu mesaj iletilir
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // yatayda merkeze hizalama
                      children: [
                        ElevatedButton(
                          //ileri butonu
                          onPressed: _updateField,
                          style: ElevatedButton.styleFrom(
                            //butonu özelleştirme
                            backgroundColor: const Color(
                                0xFFCC4646), //ileri butonunun arka plan rengi
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), //ileri butonunun köşe ovalliği
                            ),
                            minimumSize:
                                const Size(120, 45), // Sabit boyut tanımı
                          ),
                          child: const Text(
                            'İleri',
                            style: TextStyle(
                                //text için özelleştirme
                                fontSize: 20, //yazı boyutu
                                fontFamily: 'Arial', //yazı tipi
                                fontWeight:
                                    FontWeight.bold, //yazı kalınlaştırma
                                fontStyle: FontStyle.italic, //yazı italik yapma
                                color: Colors.white //yazı rengi
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateField() async {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await _firestore.updateDiseaseInfo(
          documentId: userId, diseaseInfo: _firstTextController.text);

      await _firestore.updateLastBloodDonationDate(
          documentId: userId, lastBloodDonation: _secondTextController.text);

      await _firestore.updateKilo(
          documentId: userId, kilo: _thirdTextController.text);
      // Veritabanına ekleme işlemi tamamlandığında kullanıcıya bildirim göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veriler başarıyla kaydedildi.'),
          backgroundColor: Color(0xFF504658),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
          context, homePageRoute, (route) => false);
    }
    setState(() {
      _firstTextController.clear();
      _secondTextController.clear();
      _thirdTextController.clear();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _secondText,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _secondText) {
      setState(() {
        _secondText = picked;
        _secondTextController.text =
            DateFormat("dd-MM-yyyy").format(_secondText);
      });
    }
  }
}
