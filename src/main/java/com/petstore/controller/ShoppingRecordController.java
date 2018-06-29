package com.petstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.petstore.po.Pet;
import com.petstore.po.Product;
import com.petstore.po.ShoppingRecord;
import com.petstore.service.CommodityService;
import com.petstore.service.PetService;
import com.petstore.service.ProductService;
import com.petstore.service.ShoppingCarRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ShoppingRecordController {

    @Autowired
    private PetService petService;
    @Autowired
    private ProductService productService;
    @Autowired
    private CommodityService commodityService;
    @Autowired
    private ShoppingCarRecordService shoppingCarRecordService;

    @RequestMapping(value = "/shopping_record")
    public String Shopping_record(){
        return "shopping_record";
    }

    @RequestMapping(value = "/shopping_handle")
    public String shopping_handle(){
        return "shopping_handle";
    }

    @RequestMapping(value = "/addShoppingRecord")
    @ResponseBody
    public Map<String,Object> addShoppingRecord(int userId,int id,int counts){
        System.out.println("addRecord:userId"+userId+"id:"+id+"counts:"+counts);
        int type=commodityService.getCommodity(id).getType();
        String result="";
        ShoppingRecord shoppingRecord=new ShoppingRecord();
        shoppingRecord.setUserId(userId);
        shoppingRecord.setProductId(id);
        shoppingRecord.setCount(counts);
        shoppingRecord.setOrderStatus(0);
        Date date=new Date();
        SimpleDateFormat sf=new SimpleDateFormat("yyyy-mm-dd");
        shoppingRecord.setTime(sf.format(date));
        if(type<=2){
            Pet pet=petService.getPet(id);
            pet.setCounts(2);
            petService.updatePet(pet);
            System.out.println("add record->pet counts:"+pet.getCounts()+"counts:"+counts);
            if(counts<=pet.getCounts()){
                shoppingRecord.setPrice(pet.getPrice()*counts);
                pet.setCounts(pet.getCounts()-counts);
                petService.updatePet(pet);
                result="success";
            }else{
                result="unEnough";
            }
        }else{
            Product product=productService.getProduct(id);
            System.out.println("add record->product name:"+product.getName());
            if(counts<=product.getCounts()){
                shoppingRecord.setPrice(product.getPrice()*counts);
                product.setCounts(product.getCounts()-counts);
                productService.updateProduct(product);
                result="success";
            }else{
                result="unEnough";
            }
        }
        shoppingCarRecordService.addShoppingRecord(shoppingRecord);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        resultMap.put("result",result);
        return resultMap;
    }

    @RequestMapping(value = "/getShoppingRecords")
    @ResponseBody
    public Map<String,Object> getShoppingRecords(int id){
        List<ShoppingRecord> shoppingRecordList=shoppingCarRecordService.getShoppingRecords(id);
        String shoppingRecords= JSONArray.toJSONString(shoppingRecordList);
        Map<String,Object> resultMap = new HashMap<String,Object>();
//        System.out.println("shoppingRecords:"+shoppingRecords);
        resultMap.put("result",shoppingRecords);
        return resultMap;
    }

    @RequestMapping(value = "/getShoppingRecordsByOrderStatus")
    @ResponseBody
    public Map<String,Object> getShoppingRecordsByOrderStatus(int orderStatus){
        List<ShoppingRecord> shoppingRecordList=shoppingCarRecordService.getShoppingRecordsByOrderStatus(orderStatus);
        String shoppingRecords = JSONArray.toJSONString(shoppingRecordList);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",shoppingRecords);
        return resultMap;
    }

    @RequestMapping(value = "/getAllShoppingRecords")
    @ResponseBody
    public Map<String,Object> getAllShoppingRecords(){
        List<ShoppingRecord> shoppingRecordList = shoppingCarRecordService.getAllShoppingRecords();
        String shoppingRecords = JSONArray.toJSONString(shoppingRecordList);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",shoppingRecords);
        return resultMap;
    }

    @RequestMapping(value = "/changeShoppingRecord",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> changeShoppingRecord(int userId,int productId,String time,int orderStatus){
        System.out.println("我接收了"+userId+" "+productId+" "+time+" "+orderStatus);
        ShoppingRecord shoppingRecord = shoppingCarRecordService.getShoppingRecord(userId,productId,time);
        System.out.println("我获取到了了"+shoppingRecord.getTime());
        shoppingRecord.setOrderStatus(orderStatus);
        shoppingCarRecordService.updateShoppingRecord(shoppingRecord);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/getUserProductRecord",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getUserProductRecord(int userId,int productId){
        String result = "false";
        if(shoppingCarRecordService.getUserProductRecord(userId,productId)){
            result = "true";
        }
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }

}

