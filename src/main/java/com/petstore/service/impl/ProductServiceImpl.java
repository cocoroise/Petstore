package com.petstore.service.impl;

import com.petstore.mapper.ProductMapper;
import com.petstore.po.ProductExample;
import com.petstore.service.EvaluationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petstore.po.Product;
import com.petstore.service.ProductService;
import com.petstore.util.Response;

import java.util.List;

@Service("ProductService")
public class ProductServiceImpl implements ProductService{

    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private EvaluationService productEvaluationService;

    @Override
    public Product getProduct(int id) {
        return productMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Product> getProductByType(int type) {
        ProductExample pe=new ProductExample();
        ProductExample.Criteria pec=pe.createCriteria();
        pec.andTypeIsNotNull();
        pec.andTypeEqualTo(type);
        pe.setOrderByClause("id asc");
        return productMapper.selectByExample(pe);
    }

    @Override
    public void addProduct(Product product) {
        productMapper.insert(product);
    }

    @Override
    public Response deleteProduct(int id) {
        try{
            //这里还要加购物车记录删除的操作
            productMapper.deleteByPrimaryKey(id);
            productEvaluationService.deleteEvaluationByProductId(id);
            return new Response(1,"delete product success",null);
        }catch (Exception e){
            return new Response(0,"delete product fail",null);
        }
    }

    @Override
    public boolean updateProduct(Product product) {
        return productMapper.updateByPrimaryKey(product)>0;
    }

    @Override
    public List<Product> getProductsByKeyWord(String searchKeyWord) {
        ProductExample pe=new ProductExample();
        ProductExample.Criteria pec=pe.createCriteria();
        pec.andNameLike(searchKeyWord);
        pe.setOrderByClause("id asc");
        return productMapper.selectByExample(pe);
    }

    @Override
    public List<Product> getAllProduct() {
        ProductExample pe=new ProductExample();
        ProductExample.Criteria pec=pe.createCriteria();
        pec.andProductIdIsNotNull();
        return productMapper.selectByExample(pe);
    }
}
