package com.sugarventures.alda.actionsheet;

public class MachineProductData {
    private String urlImage;
    private int remainingProduct;
    private String price;
    private String discountPrice;

    public String getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(String discountPrice) {
        this.discountPrice = discountPrice;
    }

    public MachineProductData(String urlImage, int remainingProduct) {
        this.urlImage = urlImage;
        this.remainingProduct = remainingProduct;
    }

    public MachineProductData(String urlImage, int remainingProduct, String price, String discountPrice) {
        this.urlImage = urlImage;
        this.remainingProduct = remainingProduct;
        this.price = price;
        this.discountPrice = discountPrice;
    }

    public String getUrlImage() {
        return urlImage;
    }

    public void setUrlImage(String urlImage) {
        this.urlImage = urlImage;
    }

    public int getRemainingProduct() {
        return remainingProduct;
    }

    public void setRemainingProduct(int remainingProduct) {
        this.remainingProduct = remainingProduct;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}
