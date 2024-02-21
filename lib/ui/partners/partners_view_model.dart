import 'package:frankoweb/constants/images.dart';
import 'package:frankoweb/ui/big_screen/widgets/partner_item.dart';
import 'package:stacked/stacked.dart';

class PartnersViewModel extends BaseViewModel {
  List<PartnerItem> items = [];
  List<String> partnerNames = [
    "kepro",
    "VMD Livestock Pharma",
    "Arion Fasoli",
    "Hipra",
    "Biomar",
    "Laprovet",
    "Champrix",
    "Supreme Equipment",
    "Vetko",
    "Nutriblock",
    "SKM Pharma",
    "Hebei New Centry Pharmaceuticals"
  ];
  List<String> partnerImages = [
    AppImages.kepro,
    AppImages.vmd,
    AppImages.arion,
    AppImages.hipra,
    AppImages.biomar,
    AppImages.laprovet,
    AppImages.champrix,
    AppImages.supreme,
    AppImages.vetko,
    AppImages.nutriblock,
    AppImages.skm,
    AppImages.sunway
  ];

  init() {
    formulatePartners();
  }

  formulatePartners() {
    for (int i = 0; i < partnerImages.length; i++) {
      items.add(PartnerItem(
        image: partnerImages[i],
        name: partnerNames[i],
      ));
    }
    rebuildUi();
  }
}
