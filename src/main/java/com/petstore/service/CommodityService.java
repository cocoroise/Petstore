package com.petstore.service;

import com.petstore.po.Commodity;
import com.petstore.po.Pet;
import com.petstore.po.Product;

import java.util.List;

public interface CommodityService {
    public Commodity getCommodity(int id);

    public void addCommodity(int id,int type);

    public boolean deleteCommodity(int id);

    public boolean updateCommodity(int id,int type);

    public List getAllCommodity();
}
