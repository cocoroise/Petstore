package com.petstore.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.petstore.po.ShoppingRecord;
import com.petstore.po.ShoppingRecordExample;
import com.petstore.po.ShoppingRecordKey;

public interface ShoppingRecordMapper {
    long countByExample(ShoppingRecordExample example);

    int deleteByExample(ShoppingRecordExample example);

    int deleteByPrimaryKey(ShoppingRecordKey key);

    int insert(ShoppingRecord record);

    int insertSelective(ShoppingRecord record);

    List<ShoppingRecord> selectByExample(ShoppingRecordExample example);

    ShoppingRecord selectByPrimaryKey(ShoppingRecordKey key);

    int updateByExampleSelective(@Param("record") ShoppingRecord record, @Param("example") ShoppingRecordExample example);

    int updateByExample(@Param("record") ShoppingRecord record, @Param("example") ShoppingRecordExample example);

    int updateByPrimaryKeySelective(ShoppingRecord record);

    int updateByPrimaryKey(ShoppingRecord record);
}