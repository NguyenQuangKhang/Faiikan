class OrderItem
{
 late String id;
 late String productName;
 late String productImgURL;
 late int productPrice;
 late int count;
 late String Size;
 late String Color;
 late bool isChosen= true;
 late bool isReview;

  OrderItem( String id,String n,String imgURL,int Price,int c,String size,String color,{bool IsReview = false} )
  {
    this.id =id;
    productName =n;
    productImgURL=imgURL;
    productPrice=Price;
    count =c;
    Size = size;
    Color = color;
    isReview= IsReview;
  }
}