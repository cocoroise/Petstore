package com.petstore.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.petstore.po.ShoppingCar;
import com.petstore.po.ShoppingCarExample;
import com.petstore.po.ShoppingCarKey;

public interface ShoppingCarMapper {
    long countByExample(ShoppingCarExample example);

    int deleteByExample(ShoppingCarExample example);

    int deleteByPrimaryKey(ShoppingCarKey key);

    int insert(ShoppingCar record);

    int insertSelective(ShoppingCar record);

    List<ShoppingCar> selectByExample(ShoppingCarExample example);

    ShoppingCar selectByPrimaryKey(ShoppingCarKey key);

    int updateByExampleSelective(@Param("record") ShoppingCar record, @Param("example") ShoppingCarExample example);

    int updateByExample(@Param("record") ShoppingCar record, @Param("example") ShoppingCarExample example);

    int updateByPrimaryKeySelective(ShoppingCar record);

    int updateByPrimaryKey(ShoppingCar record);
}