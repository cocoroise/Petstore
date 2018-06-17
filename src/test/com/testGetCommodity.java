package com;

import com.petstore.po.Pet;
import com.petstore.po.Product;
import com.petstore.service.CommodityService;
import com.petstore.service.PetService;
import com.petstore.service.ProductService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class testGetCommodity {
    @Autowired
    private CommodityService commodityService;
    @Autowired
    private PetService petService;
    @Autowired
    private ProductService productService;

    @Test
    public void testGetAllCommodity(){
        List list=commodityService.getAllCommodity();
        //怎么判断是pet还是product
        for(int i=0;i<list.size();i++){
            System.out.println(list.get(i).equals(Pet.class));
        }
    }

    @Test
    public void testGetPet(){
        List list=petService.getAllPets();
        for (int i=0;i<list.size();i++){
            Pet pet=(Pet)list.get(i);
            System.out.println(pet.getName());
        }
    }

    @Test
    public void testGetProduct(){
        List list=productService.getAllProduct();
        for (int i=0;i<list.size();i++){
            Product product=(Product) list.get(i);
            System.out.println(product.getName());
        }
    }
}
