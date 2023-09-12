const List ITEM_PARENT_CATEGORY = [
  'Top',
  'Outer',
  'Bottom',
  'Shoes',
  'Accessories'
];

const List ITEM_CHILD_CATEGORY = [
  'Knitwear/Sweater',
  'Collar T-shirt',
  'Hoody T-shirt',
];

class Item {
  String name = 'Item';
  String brand = 'Brand';
  String parentCategory = 'Top';
  String childCategory = 'Knitwear/Sweater';
  String size = 'M';
  String colour = 'Green';
  String imageURL =
      'https://image.msscdn.net/images/goods_img/20220303/2396645/2396645_4_500.jpg';
  int officialPrice = 59000;

  Item({
    String? itemName,
    String? itemBrand,
    String? itemParentCategory,
    String? itemChildCategory,
    String? itemSize,
    String? itemColour,
    String? itemImageURL,
    int? itemOfficialPrice,
  }) {
    name = itemName ?? name;
    brand = itemBrand ?? brand;
    parentCategory = itemParentCategory ?? parentCategory;
    childCategory = itemChildCategory ?? childCategory;
    size = itemSize ?? size;
    colour = itemColour ?? colour;
    imageURL = itemImageURL ?? imageURL;
    officialPrice = itemOfficialPrice ?? officialPrice;
  }
}
