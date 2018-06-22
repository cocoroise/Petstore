package com.petstore.controller;

import com.alibaba.fastjson.JSONArray;
import com.petstore.po.Pet;
import com.petstore.po.Product;
import com.petstore.service.CommodityService;
import com.petstore.service.PetService;
import com.petstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CommodityController {

    @Autowired
    private CommodityService commodityService;
    @Autowired
    private PetService petService;
    @Autowired
    private ProductService productService;

    @RequestMapping(value = "/petshow")
    public String petShow(){
        System.out.println("拦截到petshow请求");
        return "petshow";
    }
    @RequestMapping(value = "/productshow")
    public String productShow(){
        System.out.println("拦截到productshow请求");
        return "productshow";
    }
    @RequestMapping(value = "/search")
    public String search(){
        System.out.println("拦截到search请求");
        return "search";
    }
    @RequestMapping(value = "/petDetail")
    public String petDetail(){
        System.out.println("拦截到petdetail请求");
        return "petDetail";
    }
    @RequestMapping(value = "/productDetail")
    public String productDetail(){
        System.out.println("拦截到productDetail请求");
        return "productDetail";
    }

    @RequestMapping(value = "/getPetDetail")
    @ResponseBody
    public Map<String,Object> getPetDetail(Integer id,HttpSession httpSession){
        System.out.println("拦截到petDetail请求 id:"+id);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        Pet pet =petService.getPet(id);
        System.out.println("pet:"+pet.getName());
        httpSession.setAttribute("currentCommodity",pet);
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/getProductDetail")
    @ResponseBody
    public Map<String,Object> getProductDetail(Integer id,HttpSession httpSession){
        System.out.println("拦截到productDetail请求 id:"+id);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        Product product=productService.getProduct(id);
        System.out.println("product:"+product.getName());
        httpSession.setAttribute("currentCommodity",product);
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/onSearch",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> onSearch(String keyword, HttpSession httpSession){
        httpSession.setAttribute("searchKeyWord",keyword);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/getAllCommodity")
    @ResponseBody
    public Map<String,Object> getAllCommodity(){
        List commodityList=commodityService.getAllCommodity();
        //alibaba fastjson把jsonArray转成string
        String all= JSONArray.toJSONString(commodityList);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("all",all);
        return resultMap;
    }

    @RequestMapping(value = "getAllPets")
    @ResponseBody
    public Map<String,Object> getAllPets(){
        List pet_list=petService.getAllPets();
        String all_pet=JSONArray.toJSONString(pet_list);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("all_pet",all_pet);
        return resultMap;
    }

    @RequestMapping(value = "getAllProducts")
    @ResponseBody
    public Map<String,Object> getAllProducts(){
        List product_list=productService.getAllProduct();
        String all_product=JSONArray.toJSONString(product_list);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("all_product",all_product);
        return resultMap;
    }
}
