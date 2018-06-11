package com.petstore.service.impl;

import com.petstore.mapper.CommodityMapper;
import com.petstore.po.Commodity;
import com.petstore.service.CommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("CommodityService")
public class CommodityServiceImpl implements CommodityService{

    @Autowired
    private CommodityMapper commodityMapper;

    @Override
    public Commodity getCommodity(int id) {
        return commodityMapper.selectByPrimaryKey(id);
    }

    @Override
    public void addCommodity(int id, int type) {
        Commodity c=new Commodity();
        c.setId(id);
        c.setType(type);
        commodityMapper.insert(c);
    }

    @Override
    public boolean deleteCommodity(int id) {
        return commodityMapper.deleteByPrimaryKey(id)>0;
    }

    @Override
    public boolean updateCommodity(int id, int type) {
        Commodity c=new Commodity();
        c.setId(id);
        c.setType(type);
        return commodityMapper.updateByPrimaryKey(c)>0;
    }
}
