package com.petstore.service.impl;

import com.petstore.mapper.ShoppingRecordMapper;
import com.petstore.po.ShoppingRecord;
import com.petstore.po.ShoppingRecordExample;
import com.petstore.po.ShoppingRecordKey;
import com.petstore.service.ShoppingCarRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ShoppingCarRecordService")
public class ShoppingCarRecordServiceImpl implements ShoppingCarRecordService{

    @Autowired
    private ShoppingRecordMapper shoppingRecordMapper;

    @Override
    public ShoppingRecord getShoppingRecord(int userId, int Id, String time) {
        ShoppingRecordKey key=new ShoppingRecordKey();
        key.setUserId(userId);
        key.setProductId(Id);
        key.setTime(time);
        return shoppingRecordMapper.selectByPrimaryKey(key);
    }

    @Override
    public void addShoppingRecord(ShoppingRecord shoppingRecord) {
        shoppingRecordMapper.insert(shoppingRecord);
    }

    @Override
    public boolean deleteShoppingRecord(int userId, int Id) {
        ShoppingRecordKey key=new ShoppingRecordKey();
        key.setUserId(userId);
        key.setProductId(Id);
        return shoppingRecordMapper.deleteByPrimaryKey(key)>0;
    }

    @Override
    public boolean updateShoppingRecord(ShoppingRecord shoppingRecord) {
        return shoppingRecordMapper.updateByPrimaryKey(shoppingRecord)>0;
    }

    @Override
    public List<ShoppingRecord> getShoppingRecordsByOrderStatus(int orderStatus) {
        ShoppingRecordExample example=new ShoppingRecordExample();
        ShoppingRecordExample.Criteria srec=example.createCriteria();
        srec.andOrderStatusIsNotNull();
        srec.andOrderStatusEqualTo(orderStatus);
        example.setOrderByClause("orderStatus asc");
        return shoppingRecordMapper.selectByExample(example);
    }

    @Override
    public List<ShoppingRecord> getShoppingRecords(int userId) {
        ShoppingRecordExample example=new ShoppingRecordExample();
        ShoppingRecordExample.Criteria srec=example.createCriteria();
        srec.andUserIdIsNotNull();
        srec.andUserIdEqualTo(userId);
        example.setOrderByClause("userId asc");
        return shoppingRecordMapper.selectByExample(example);
    }

    @Override
    public List<ShoppingRecord> getAllShoppingRecords() {
        ShoppingRecordExample example=new ShoppingRecordExample();
        ShoppingRecordExample.Criteria srec=example.createCriteria();
        srec.andUserIdIsNotNull();
        example.setOrderByClause("userId");
        return shoppingRecordMapper.selectByExample(example);
    }

    @Override
    public boolean getUserRecord(int userId, int Id) {
        ShoppingRecordKey key=new ShoppingRecordKey();
        key.setUserId(userId);
        key.setProductId(Id);
        return shoppingRecordMapper.selectByPrimaryKey(key).getPrice()>0;
    }
}
