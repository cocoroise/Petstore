package com.petstore.service;

import com.petstore.po.ShoppingRecord;

import java.util.List;

public interface ShoppingCarRecordService {
    public ShoppingRecord getShoppingRecord(int userId, int Id, String time);

    public void addShoppingRecord(ShoppingRecord shoppingRecord);

    public boolean deleteShoppingRecord(int userId,int productId);

    public boolean updateShoppingRecord(ShoppingRecord shoppingRecord);

    public List<ShoppingRecord> getShoppingRecordsByOrderStatus(int orderStatus);

    public List<ShoppingRecord> getShoppingRecords(int userId);

    public List<ShoppingRecord> getAllShoppingRecords();

    public boolean getUserRecord(int userId,int Id);

}
