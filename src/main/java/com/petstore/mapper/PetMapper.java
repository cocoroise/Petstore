package com.petstore.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.petstore.po.Pet;
import com.petstore.po.PetExample;

public interface PetMapper {
    long countByExample(PetExample example);

    int deleteByExample(PetExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Pet record);

    int insertSelective(Pet record);

    List<Pet> selectByExample(PetExample example);

    Pet selectByPrimaryKey(Integer id);

    //自定义模糊查询
    List<Pet> selectByKeyWord(String keyword);

    int updateByExampleSelective(@Param("record") Pet record, @Param("example") PetExample example);

    int updateByExample(@Param("record") Pet record, @Param("example") PetExample example);

    int updateByPrimaryKeySelective(Pet record);

    int updateByPrimaryKey(Pet record);
}