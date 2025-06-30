enum CatBreed {
  britishShorthair,
  scottishFold,
  maineCoon,
  domesticShorthair,
  ragdoll,
  sphynx,
  abyssinian,
  persian,
  siamese,
  bengal,
}

extension CatBreedExtension on CatBreed {
  String get label {
    switch (this) {
      case CatBreed.britishShorthair:
        return 'British Shorthair';
      case CatBreed.scottishFold:
        return 'Scottish Fold';
      case CatBreed.maineCoon:
        return 'Maine Coon';
      case CatBreed.domesticShorthair:
        return 'Domestic Shorthair';
      case CatBreed.ragdoll:
        return 'Ragdoll';
      case CatBreed.sphynx:
        return 'Sphynx';
      case CatBreed.abyssinian:
        return 'Abyssinian';
      case CatBreed.persian:
        return 'Persian';
      case CatBreed.siamese:
        return 'Siamese';
      case CatBreed.bengal:
        return 'Bengal';
    }
  }
}
