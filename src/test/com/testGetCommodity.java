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
        Pet pet=petService.getPet(2);
        pet.setCounts(4);
        petService.updatePet(pet);
        System.out.println(pet.getCounts());
    }

    @Test
    public void testGetProduct(){
        Product product=productService.getProduct(18);
        System.out.println(product.getCounts());
    }

    @Test
    public void testGetCommodityById(){
        int type=commodityService.getCommodity(13).getType();
        System.out.println(type);
    }

    @Test
    public void testGetKeyWordForPet(){
        String testStr="柯";
        List<Pet> list=petService.getPetsByKeyWord(testStr);
        System.out.println(list.size());

        for(int i=0;i<list.size();i++){
            System.out.println("i:"+list.get(i).getName());
        }
    }

    @Test
    public void testGetKeyWordForProduct(){
        String testStr="粮";
        List<Product> list=productService.getProductsByKeyWord(testStr);
        for(Product product:list){
            System.out.println(product.getName());
        }
    }
}
