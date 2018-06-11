package com.petstore.service.impl;

import com.petstore.mapper.ShoppingCarMapper;
import com.petstore.po.ShoppingCar;
import com.petstore.po.ShoppingCarExample;
import com.petstore.po.ShoppingCarKey;
import com.petstore.service.ShoppingCarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ShoppingCarService")
public class ShoppingCarServiceImpl  implements ShoppingCarService{

    @Autowired
    private ShoppingCarMapper shoppingCarMapper;

    @Override
    public ShoppingCar getShoppingCar(int userId, int productId) {
        ShoppingCarKey key=new ShoppingCarKey();
        key.setUserId(userId);
        key.setProductId(productId);
        return shoppingCarMapper.selectByPrimaryKey(key);
    }


    @Override
    public void addShoppingCar(ShoppingCar shoppingCar) {
        shoppingCarMapper.insertSelective(shoppingCar);
    }

    @Override
    public boolean deleteShoppingCar(int userId, int productId) {
        ShoppingCarKey key=new ShoppingCarKey();
        key.setUserId(userId);
        key.setProductId(productId);
        return shoppingCarMapper.deleteByPrimaryKey(key)>0;
    }

    @Override
    public boolean updateShoppingCar(ShoppingCar shoppingCar) {
        return shoppingCarMapper.updateByPrimaryKey(shoppingCar)>0;
    }

    @Override
    public List<ShoppingCar> getShoppingCars(int userId) {
        ShoppingCarExample example=new ShoppingCarExample();
        ShoppingCarExample.Criteria scec=example.createCriteria();
        scec.andUserIdIsNotNull();
        return shoppingCarMapper.selectByExample(example);
    }
}
