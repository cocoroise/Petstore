package com.petstore.service;

import com.petstore.po.Product;
import com.petstore.util.Response;

import java.util.List;

public interface ProductService {
    public Product getProduct(int id);

    public List<Product> getProductByType(int type);

    public void addProduct(Product product);

    Response deleteProduct(int id);

    public boolean updateProduct(Product product);

    public List<Product> getProductsByKeyWord(String searchKeyWord);

    public List<Product> getAllProduct();
}
