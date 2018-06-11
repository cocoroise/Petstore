package com.petstore.po;

public class ShoppingCar extends ShoppingCarKey {
    private Integer counts;

    private Double price;

    public Integer getCounts() {
        return counts;
    }

    public void setCounts(Integer counts) {
        this.counts = counts;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}