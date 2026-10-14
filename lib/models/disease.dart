class Disease {
  final String id;
  final String nameEn;
  final String nameBn;
  final String scientificName;
  final String descriptionEn;
  final String descriptionBn;
  final List<String> symptomsEn;
  final List<String> symptomsBn;
  final List<String> treatmentEn;
  final List<String> treatmentBn;
  final List<String> preventionEn;
  final List<String> preventionBn;
  final String causesEn;
  final String causesBn;
  final String severity; // 'high', 'medium', 'low', 'healthy'

  const Disease({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.scientificName,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.symptomsEn,
    required this.symptomsBn,
    required this.treatmentEn,
    required this.treatmentBn,
    required this.preventionEn,
    required this.preventionBn,
    required this.causesEn,
    required this.causesBn,
    required this.severity,
  });

  String getName(bool isBangla) => isBangla ? nameBn : nameEn;
  String getDescription(bool isBangla) => isBangla ? descriptionBn : descriptionEn;
  List<String> getSymptoms(bool isBangla) => isBangla ? symptomsBn : symptomsEn;
  List<String> getTreatment(bool isBangla) => isBangla ? treatmentBn : treatmentEn;
  List<String> getPrevention(bool isBangla) => isBangla ? preventionBn : preventionEn;
  String getCauses(bool isBangla) => isBangla ? causesBn : causesEn;

  static const List<Disease> diseaseLibrary = [
    Disease(
      id: 'rice_blast',
      nameEn: 'Rice Blast',
      nameBn: 'ধানের ব্লাস্ট রোগ',
      scientificName: 'Magnaporthe oryzae',
      descriptionEn: 'Rice Blast is one of the most destructive fungal diseases affecting rice leaves, nodes, and panicles. It causes diamond-shaped or spindle spots.',
      descriptionBn: 'ধানের ব্লাস্ট অত্যন্ত ক্ষতিকর ছত্রাকজনিত রোগ। এটি পাতায় চোখের মতো বা মাকু আকৃতির দাগ তৈরি করে এবং শীষ শুকিয়ে ফেলে।',
      symptomsEn: [
        'Spindle-shaped or diamond-shaped spots on leaves',
        'Center of spots becomes ash-gray with reddish-brown borders',
        'Panicle neck rot causing empty white grains (neck blast)',
        'Leaves dry up and look burned in severe conditions'
      ],
      symptomsBn: [
        'পাতায় চোখের মতো বা মাকু আকৃতির বাদামী-ধূসর দাগ',
        'দাগের কেন্দ্রস্থল ধূসর এবং চারপাশ লালচে বাদামী রঙের হয়',
        'শীষের গোড়া কালো হয়ে ভেঙে পড়ে (শীষ ব্লাস্ট)',
        'আক্রান্ত পাতা দ্রুত শুকিয়ে পুড়ে যাওয়ার মতো দেখায়'
      ],
      treatmentEn: [
        'Spray Tricyclazole 75 WP (e.g., Trooper) @ 0.75g per liter of water',
        'Apply Isoprothiolane 40 EC (e.g., Fuji-one) @ 2ml per liter',
        'Avoid excessive Nitrogen fertilizer; apply extra Potash fertilizer'
      ],
      treatmentBn: [
        'ট্রাইসাইক্লাজল ৭৫ ডব্লিউপি (যেমন: ট্রুপার) প্রতি লিটার পানিতে ০.৭৫ গ্রাম স্প্রে করুন',
        'আইসোপ্রোথিওলেন ৪০ ইসি (যেমন: ফুজি-ওয়ান) প্রতি লিটার পানিতে ২ মি.লি. স্প্রে করুন',
        'ইউরিয়া সারের মাত্রা কমিয়ে অতিরিক্ত পটাশ সার ব্যবহার করুন'
      ],
      preventionEn: [
        'Use disease-resistant seeds (BRRI dhan28, BRRI dhan89)',
        'Treat seeds with Carbendazim before sowing',
        'Maintain balanced field water level'
      ],
      preventionBn: [
        'রোগ প্রতিরোধী ধানের জাত ব্যবহার করুন (যেমন: ব্রি ধান৮৯, ব্রি ধান৯২)',
        'বীজ বপনের পূর্বে কার্বেনডাজিম দিয়ে বীজ শোধন করুন',
        'জমি অতিরিক্ত শুকিয়ে ফেলা পরিহার করুন'
      ],
      causesEn: 'Fungal infection spread by airborne spores in high humidity, warm days, and cool nights.',
      causesBn: 'উচ্চ আর্দ্রতা, ঘন কুয়াশা এবং অতিরিক্ত ইউরিয়া সারের ব্যবহারের ফলে বায়ুবাহিত ছত্রাক স্পোর দিয়ে ছড়িয়ে পড়ে।',
      severity: 'high',
    ),
    Disease(
      id: 'bacterial_leaf_blight',
      nameEn: 'Bacterial Leaf Blight',
      nameBn: 'ব্যাকটেরিয়াল লিফ ব্লাইট',
      scientificName: 'Xanthomonas oryzae pv. oryzae',
      descriptionEn: 'Bacterial leaf blight causes water-soaked lesions that enlarge and turn yellow to white, leading to leaf wilting and drying.',
      descriptionBn: 'এটি একটি ভয়াবহ ব্যাকটেরিয়াঘটিত রোগ। পাতার কিনারা থেকে হলুদ ও শুকনা দাগ সৃষ্টি হয়ে পাতা শুকিয়ে যায়।',
      symptomsEn: [
        'Water-soaked lesions on leaf margins starting from tips',
        'Wavy yellowish-white drying along leaf edges',
        'Bacterial ooze droplets on leaves during early morning',
        'Leaves turn straw-colored and die rapidly'
      ],
      symptomsBn: [
        'পাতার ডগা বা কিনারা ধরে ঢেউখেলানো হলুদ-সাদা দাগ',
        'সকালে পাতার উপরিভাগে আঠালো ব্যাকটেরিয়ার ফোঁটা দেখা যায়',
        'আক্রান্ত পাতা খড়ের মতো রঙ ধারণ করে শুকিয়ে মরে যায়',
        'গাছের বৃদ্ধি থমকে যায় ও ফলন ব্যাপকভাবে কমে'
      ],
      treatmentEn: [
        'Spray Copper Oxychloride @ 2g/L mixed with Agrimycin @ 0.2g/L',
        'Apply Potassium Nitrate or Potash to boost resistance',
        'Drain water from infected field for 3-4 days'
      ],
      treatmentBn: [
        'কপার অক্সিক্লোরাইড (যেমন: কুপ্রোফিক্স) প্রতি লিটারে ২ গ্রাম এবং এগ্রিমাইসিন ০.২ গ্রাম মিশিয়ে স্প্রে করুন',
        'জমির পানি ৩-৪ দিন নিষ্কাশন করে শুকনো রাখুন',
        'অতিরিক্ত পটাশ সার প্রয়োগ করে গাছের রোগ প্রতিরোধ ক্ষমতা বাড়ান'
      ],
      preventionEn: [
        'Avoid trimming seedling tops during transplanting',
        'Keep balanced Nitrogen and Potash ratio',
        'Avoid flooding water from infected fields'
      ],
      preventionBn: [
        'চারা রোপণের সময় চারার ডগা কাটা থেকে বিরত থাকুন',
        'আক্রান্ত জমির পানি অন্য জমিতে যেতে দেবেন না',
        'সুষম মাত্রায় সার ব্যবহার করুন'
      ],
      causesEn: 'Bacterial infection spread through rain splashes, wind, and irrigation water.',
      causesBn: 'বৃষ্টির পানির ঝাপটা, বাতাস এবং সেচের পানির মাধ্যমে ব্যাকটেরিয়া এক গাছ থেকে অন্য গাছে ছড়ায়।',
      severity: 'high',
    ),
    Disease(
      id: 'brown_spot',
      nameEn: 'Brown Spot',
      nameBn: 'বাদামী দাগ রোগ',
      scientificName: 'Cochliobolus miyabeanus',
      descriptionEn: 'Brown spot disease appears as oval or circular dark brown spots with yellow halos, mainly on nutrient-deficient soils.',
      descriptionBn: 'পুষ্টির অভাবযুক্ত মাটিতে এই রোগ বেশি দেখা যায়। পাতায় ডিম্বাকৃতির ছোট ছোট বাদামী দাগ তৈরি হয়।',
      symptomsEn: [
        'Small oval or circular brown spots on leaf blades',
        'Spots have yellow or light brown halo surrounding them',
        'Grains become discolored, spotted, and light in weight',
        'Seedlings can wither and collapse'
      ],
      symptomsBn: [
        'পাতায় ছোট ডিম্বাকৃতির গাঢ় বাদামী দাগ',
        'দাগের চারপাশে হালকা হলুদ বলয় (Halo) দেখা যায়',
        'ধানের দানা কালো বা বাদামী দাগযুক্ত হয়ে চিটা হয়ে যায়',
        'চারা অবস্থায় আক্রমণ হলে চারা নেতিয়ে পড়ে'
      ],
      treatmentEn: [
        'Spray Mancozeb 75 WP (e.g., Dithane M-45) @ 2g/L',
        'Apply Propiconazole 25 EC (e.g., Tilt) @ 1ml/L of water',
        'Apply Potash and Zinc fertilizers to balance soil nutrients'
      ],
      treatmentBn: [
        'ম্যানকোজেব ৭৫ ডব্লিউপি (যেমন: ডাইথেন এম-৪৫) প্রতি লিটার পানিতে ২ গ্রাম স্প্রে করুন',
        'প্রোপিকোনাজল ২৫ ইসি (যেমন: টিল্ট) প্রতি লিটারে ১ মি.লি. প্রয়োগ করুন',
        'জমি প্রস্তুতকালে সুষম পটাশ ও জিংক সার দিন'
      ],
      preventionEn: [
        'Seed treatment with Carbendazim before planting',
        'Ensure proper soil fertility with organic matter and Potash',
        'Maintain proper plant spacing'
      ],
      preventionBn: [
        'বীজ কার্বেনডাজিম দিয়ে শোধন করে রোপণ করুন',
        'জমি প্রস্তুতের সময় পর্যাপ্ত জৈব সার ও জিংক প্রয়োগ করুন',
        'সঠিক দূরত্বে চারা রোপণ করুন'
      ],
      causesEn: 'Nutrient deficiencies (especially Nitrogen & Potassium) combined with airborne fungal spores.',
      causesBn: 'মাটিতে পটাশ ও পটাশিয়ামের অভাব এবং স্যাঁতসেঁতে আবহাওয়ায় ছত্রাক ছড়িয়ে পড়ার কারণে হয়।',
      severity: 'medium',
    ),
    Disease(
      id: 'sheath_blight',
      nameEn: 'Sheath Blight',
      nameBn: 'খোল পচা রোগ',
      scientificName: 'Rhizoctonia solani',
      descriptionEn: 'Sheath blight occurs at water lines, producing greenish-gray oval lesions that expand up the leaf sheath, causing lodging.',
      descriptionBn: 'পানির উপরিভাগে গাছের খোল বা কাণ্ডে ডিম্বাকৃতির সবুজ-ধূসর পচা দাগ তৈরি হয় এবং গাছ ঢলে পড়ে।',
      symptomsEn: [
        'Greenish-gray oval lesions on sheaths near water level',
        'Lesions merge, turning white-gray with brownish borders',
        'Fungal threads (sclerotia) visible inside sheaths',
        'Stems soften, leading to plant lodging and broken tillers'
      ],
      symptomsBn: [
        'পানির ঠিক ওপরে কাণ্ডের খোলে সবুজাভ-ধূসর ডিম্বাকৃতি পচা দাগ',
        'দাগগুলো বড় হয়ে একত্রে মিশে যায় এবং খোল শুকিয়ে ফেলে',
        'খোলের ওপর সরিষার দানার মতো ছত্রাক গুটি (Sclerotia) দেখা যায়',
        'গাছের কান্ড দুর্বল হয়ে নেতিয়ে পড়ে'
      ],
      treatmentEn: [
        'Spray Hexaconazole 5 EC (e.g., Contaf) @ 2ml/L',
        'Spray Validamycin 3L @ 2ml per liter of water directly at stem base',
        'Keep water level low during early growth stage'
      ],
      treatmentBn: [
        'হেক্সাকোনাজল ৫ ইসি (যেমন: কনটাফ) প্রতি লিটার পানিতে ২ মি.লি. স্প্রে করুন',
        'ভ্যালিডামাইসিন ৩এল (যেমন: ভ্যালিডাসিন) গাছের গোড়ায় ভালোভাবে স্প্রে করুন',
        'আক্রান্ত ক্ষেত থেকে পানি বের করে জমি শুকিয়ে নিন'
      ],
      preventionEn: [
        'Avoid overly dense planting',
        'Keep field borders clean of weeds',
        'Apply split dose of Nitrogen fertilizers'
      ],
      preventionBn: [
        'ঘন করে চারা রোপণ করবেন না, পর্যাপ্ত আলো-বাতাস চলাচলের ব্যবস্থা রাখুন',
        'জমির আইল ও জঙ্গল পরিষ্কার পরিচ্ছন্ন রাখুন',
        'ইউরিয়া সার কিস্তিতে প্রয়োগ করুন'
      ],
      causesEn: 'Soil-borne fungal sclerotia floating in water during hot and humid weather.',
      causesBn: 'উষ্ণ ও স্যাঁতসেঁতে আবহাওয়ায় মাটিতে থাকা ছত্রাক গুটি পানির সাহায্যে কাণ্ডের খোলে আক্রমণ করে।',
      severity: 'high',
    ),
    Disease(
      id: 'tungro_disease',
      nameEn: 'Tungro Disease',
      nameBn: 'টুংরো রোগ',
      scientificName: 'Rice Tungro Spherical/Bacilliform Virus',
      descriptionEn: 'Tungro is a viral disease spread by green leafhoppers, causing severe stunting, yellow-orange discoloration, and reduced tillering.',
      descriptionBn: 'সবুজ পাতাফোড়িং বা সবুজ জাসিড পোকা দ্বারা বাহিত ভাইরাসের কারণে এই রোগ হয়। গাছ খর্বাকৃতি ও পাতা হলুদ হয়ে যায়।',
      symptomsEn: [
        'Stunting and severe reduction in tiller numbers',
        'Leaves turn bright yellow to orange from tip downwards',
        'Young leaves show mottling and rusty brown spots',
        'Panicles fail to emerge or are partially filled'
      ],
      symptomsBn: [
        'গাছ ছোট বা খর্বাকৃতি থেকে যায় ও কুশি গজায় না',
        'পাতার ডগা থেকে শুরু করে পুরো পাতা চকচকে হলুদ থেকে কমলা রঙ ধারণ করে',
        'কচি পাতায় হালকা ছোপ ছোপ দাগ দেখা যায়',
        'গাছে শীষ বের হয় না বা হলেও হালকা চিটা ধান হয়'
      ],
      treatmentEn: [
        'Control vector insect (Green Leafhopper) with Imidacloprid (e.g., Admire) @ 0.5ml/L',
        'Apply MIPC or Thiamethoxam insecticides immediately',
        'Uproot and bury severely infected plants to halt spread'
      ],
      treatmentBn: [
        'রোগের বাহক সবুজ পাতাফোড়িং দমনে ইমিডাক্লোপ্রিড (যেমন: এডমায়ার) ০.৫ মি.লি./লিটার স্প্রে করুন',
        'থায়ামেথক্সাম বা এমআইপিসি কীটনাশক দ্রুত স্প্রে করুন',
        'আক্রান্ত গাছ তুলে মাটির নিচে পুঁতে ফেলুন যাতে রোগ ছড়াতে না পারে'
      ],
      preventionEn: [
        'Plant resistant varieties',
        'Synchronized planting across neighboring fields',
        'Monitor and suppress green leafhopper population in seedbeds'
      ],
      preventionBn: [
        'একত্রে একই সময়ে সকল কৃষক মিলে চারা রোপণ করুন',
        'বীজতলায় সবুজ পাতাফোড়িং দমনে সতর্ক থাকুন',
        'টুংরো প্রতিরোধী ধানের জাত চাষ করুন'
      ],
      causesEn: 'Viral infection transmitted rapidly by Green Leafhoppers (GLH).',
      causesBn: 'সবুজ পাতাফোড়িং (Green Leafhopper) এক গাছ থেকে রক্ত চুষে অন্য গাছে ভাইরাস ছড়িয়ে দেয়।',
      severity: 'high',
    ),
    Disease(
      id: 'healthy',
      nameEn: 'Healthy Paddy Leaf',
      nameBn: 'নীরোগ ধানের পাতা',
      scientificName: 'Oryza sativa (Healthy)',
      descriptionEn: 'The paddy crop shows optimal green color, vigorous growth, upright foliage, and no signs of fungal or bacterial lesions.',
      descriptionBn: 'ধান গাছটি সম্পূর্ণ সতেজ, গাঢ় সবুজ এবং সবল। এতে কোনো ছত্রাক বা ব্যাকটেরিয়ার লক্ষণ নেই।',
      symptomsEn: [
        'Uniform bright green leaf color',
        'Clean leaf surface without spots, wilting, or yellowing',
        'Strong upright leaf orientation and healthy panicle development'
      ],
      symptomsBn: [
        'গাঢ় সবুজ ও সতেজ পাতা',
        'পাতায় কোনো দাগ, পচন বা হলদে ভাব নেই',
        'গাছ সবল ও সতেজভাবে বৃদ্ধি পাচ্ছে'
      ],
      treatmentEn: [
        'No chemical treatment needed.',
        'Maintain regular irrigation and balanced organic fertilization.'
      ],
      treatmentBn: [
        'কোনো রাসায়নিক বা ওষুধের প্রয়োজন নেই।',
        'নিয়মিত পানি সেচ ও সুষম সার প্রয়োগ বজায় রাখুন।'
      ],
      preventionEn: [
        'Continue good agricultural practices and balanced field management.',
      ],
      preventionBn: [
        'নিয়মিত খেত পরিদর্শন করুন ও সুষম সেচ বজায় রাখুন।',
      ],
      causesEn: 'Good crop health management and disease-free environment.',
      causesBn: 'সঠিক পরিচর্যা ও সুষম সারের ব্যবহার।',
      severity: 'healthy',
    ),
  ];

  static Disease getById(String id) {
    return diseaseLibrary.firstWhere(
      (d) => d.id.toLowerCase() == id.toLowerCase(),
      orElse: () => diseaseLibrary.first,
    );
  }

  static Disease matchByNameOrClass(String query) {
    final q = query.toLowerCase().replaceAll('_', ' ').replaceAll('-', ' ');
    for (final d in diseaseLibrary) {
      if (d.id.toLowerCase() == q ||
          d.nameEn.toLowerCase().contains(q) ||
          d.nameBn.contains(query) ||
          q.contains(d.id.replaceAll('_', ' '))) {
        return d;
      }
    }
    // Check partial matches
    if (q.contains('blast')) return diseaseLibrary[0];
    if (q.contains('blight') || q.contains('bacterial')) return diseaseLibrary[1];
    if (q.contains('brown') || q.contains('spot')) return diseaseLibrary[2];
    if (q.contains('sheath')) return diseaseLibrary[3];
    if (q.contains('tungro')) return diseaseLibrary[4];
    if (q.contains('healthy') || q.contains('normal')) return diseaseLibrary[5];

    return diseaseLibrary.first;
  }
}
