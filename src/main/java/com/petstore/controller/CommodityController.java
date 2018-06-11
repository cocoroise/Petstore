package com.petstore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommodityController {
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

}
