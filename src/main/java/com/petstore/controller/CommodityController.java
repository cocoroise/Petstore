package com.petstore.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.petstore.po.Pet;
import com.petstore.po.Product;
import com.petstore.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
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
    @Autowired
    private ShoppingCarService shoppingCarService;
    @Autowired
    private ShoppingCarRecordService shoppingCarRecordService;

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
    public String searchto(){
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

    @RequestMapping(value = "/edit_pet")
    public String editPet(){
        return "edit_pet";
    }

    @RequestMapping(value = "/edit_product")
    public String editProduct(){
        return "edit_product";
    }


    @RequestMapping(value = "/getPetDetail")
    @ResponseBody
    public Map<String,Object> getPetDetail(Integer id,HttpSession httpSession){
        System.out.println("拦截到petDetail请求 id:"+id);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        Pet pet =petService.getPet(id);
        petService.updatePet(pet);
        System.out.println("pet:"+pet.getName());
        httpSession.setAttribute("currentCommodity",pet);
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/getProductDetail")
    @ResponseBody
    public Map<String,Object> getProductDetail(Integer productId,HttpSession httpSession){
        System.out.println("拦截到getproductDetail请求 id:"+productId);
        Map<String,Object> resultMap=new HashMap<String, Object>();
        Product product=productService.getProduct(productId);
        System.out.println("product:"+product.getName());
        httpSession.setAttribute("currentCommodity",product);
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/getCommodityById")
    @ResponseBody
    public Map<String,Object> getCommodityById(int id){
        int type=commodityService.getCommodity(id).getType();
        Map<String,Object> resultMap=new HashMap<String, Object>();
        String result="";
        if(type<=2){
            Pet pet=petService.getPet(id);
            result= JSONArray.toJSONString(pet);
        }else{
            Product product=productService.getProduct(id);
            result=JSONArray.toJSONString(product);
        }
        resultMap.put("result",result);
        resultMap.put("type",type);
        return resultMap;
    }

    @RequestMapping(value = "/onSearch",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> onSearch(String text, HttpSession httpSession){
        System.out.println("onSearch->text:"+text);
        httpSession.setAttribute("searchKeyWord",text);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/searchResult",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> SearchResult(String text){
        System.out.println("SearchResult->text:"+text);
        List list=new ArrayList();
        list.add(petService.getPetsByKeyWord(text));
        list.add(productService.getProductsByKeyWord(text));
        String resultList=JSONArray.toJSONString(list);
        System.out.println("search->resultList:"+resultList);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("searchResult",resultList);
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

    @RequestMapping(value = "/getAllPets")
    @ResponseBody
    public Map<String,Object> getAllPets(){
        List pet_list=petService.getAllPets();
        String all_pet=JSONArray.toJSONString(pet_list);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("all_pet",all_pet);
        return resultMap;
    }

    @RequestMapping(value = "/getAllProducts")
    @ResponseBody
    public Map<String,Object> getAllProducts(){
        List product_list=productService.getAllProduct();
        String all_product=JSONArray.toJSONString(product_list);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("all_product",all_product);
        return resultMap;
    }

    @RequestMapping(value = "/addPet")
    @ResponseBody
    public Map<String,Object> addPet(String name,int age,int type,double price,String description,String keyword,int counts){
        System.out.println("add pet->name:"+name);
        Pet pet=new Pet();
        pet.setName(name);
        pet.setAge(age);
        pet.setType(type);
        pet.setCounts(counts);
        pet.setPrice(price);
        pet.setDescription(description);
        pet.setKeyWord(keyword);
        petService.addPet(pet);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/deletePet")
    @ResponseBody
    public Map<String,Object> deletePet(int id){
        System.out.println("delete pet->id:"+id);
        petService.deletePet(id);
        shoppingCarService.deleteShoppingCarById(id);
        shoppingCarRecordService.deleteShoppingRecordById(id);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/updatePet")
    @ResponseBody
    public Map<String,Object> updatePet(int id,String name,int age,int type,double price,String description,String keyword){
        Pet pet=petService.getPet(id);
        pet.setName(name);
        pet.setAge(age);
        pet.setType(type);
        pet.setCounts(1);
        pet.setPrice(price);
        pet.setDescription(description);
        pet.setKeyWord(keyword);
        petService.updatePet(pet);

        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/deleteProduct")
    @ResponseBody
    public Map<String,Object> deleteProduct(int id){
        int status=productService.deleteProduct(id).getStatus();
        Map<String,Object> resultMap=new HashMap<String,Object>();
        if(status==1){
            resultMap.put("result","success");
        }
        return resultMap;
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam MultipartFile productImgUpload, int name, HttpServletRequest request) {
        String result = "fail";
        try{
            if(productImgUpload != null && !productImgUpload.isEmpty()) {
                String fileRealPath = request.getSession().getServletContext().getRealPath("/static/img/pet");
                String fileName = String.valueOf(name)+".jpg";
                File fileFolder = new File(fileRealPath);
                System.out.println("fileRealPath=" + fileRealPath+"/"+fileName);
                if(!fileFolder.exists()){
                    fileFolder.mkdirs();
                }
                File file = new File(fileFolder,fileName);
                productImgUpload.transferTo(file);
                result = "success";
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }
}
