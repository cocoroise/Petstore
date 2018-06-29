package com.petstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.petstore.po.ShoppingCar;
import com.petstore.service.PetService;
import com.petstore.service.ProductService;
import com.petstore.service.ShoppingCarService;
import com.petstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ShoppingCarController {

    @Autowired
    private ShoppingCarService shoppingCarService;
    @Autowired
    private UserService userService;
    @Autowired
    private PetService petService;
    @Autowired
    private ProductService productService;


    @RequestMapping(value = "/shopping_car")
    public String Shopping_Car(){
        return "shopping_car";
    }

    @RequestMapping(value = "/getShoppingCar",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getShoppingCar(Integer id){
        System.out.println("get-shoppingcar-Id:"+id);
        List<ShoppingCar> shoppingCarList=shoppingCarService.getShoppingCars(id);
        String shoppingCars= JSONArray.toJSONString(shoppingCarList);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        resultMap.put("result",shoppingCars);
        return resultMap;
    }

    @RequestMapping(value = "/addShoppingCar")
    @ResponseBody
    public Map<String,Object> addShoppingCar(int userId, int productId, int type, int counts){
        System.out.println("add-shoppingcar-productId:"+productId);
        ShoppingCar shoppingCar=shoppingCarService.getShoppingCar(userId,productId);
        if(shoppingCar==null){
            ShoppingCar s=new ShoppingCar();
            s.setUserId(userId);
            s.setCounts(counts);
            s.setProductId(productId);
            if(type<=2){
                s.setPrice(petService.getPet(productId).getPrice());
            }else{
                s.setPrice(productService.getProduct(productId).getPrice());
            }
            shoppingCarService.addShoppingCar(s);
        }else{
            shoppingCar.setCounts(shoppingCar.getCounts()+counts);
            shoppingCarService.updateShoppingCar(shoppingCar);
        }
        Map<String,Object> resultMap=new HashMap<String, Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/deleteShoppingCar")
    @ResponseBody
    public Map<String,Object> deleteShoppingCar(int userId,int commodityId){
        System.out.println("delete shopping car->userId"+userId);
        shoppingCarService.deleteShoppingCar(userId,commodityId);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        resultMap.put("result","success");
        return resultMap;
    }


}
