package com.petstore.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.petstore.po.User;
import com.petstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    //映射页面
    @RequestMapping(value = "/contact")
    public String contact(){
        System.out.println("拦截到contact请求");
        return "contact";
    }

    @RequestMapping(value = "/admin")
    public String admin(){
        System.out.println("拦截到admin请求");
        return "admin";
    }

    @RequestMapping(value = "/login")
    public String login(){
        System.out.println("拦截到login请求");
        return "login";
    }

    @RequestMapping(value = "/register")
    public String register(){
        System.out.println("register");
        return "register";
    }

    @RequestMapping(value = "/editMessage")
    public String edit(){
        return "editMessage";
    }

    @RequestMapping(value = "/error")
    public String error(){
        return "error";
    }

    //映射方法名
    @RequestMapping(value = "/doLogin",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> doLogin(String email, String password, HttpSession httpSession) {
        System.out.println("我接收到了登录请求" + email + " " + password);
        String result = "fail";
        User user = userService.getUserByEmail(email);
        if (user == null)
            result = "unexist";
        else {
            if (user.getPassword().equals(password)) {
                result = "success";
                httpSession.setAttribute("currentUser", user);
            } else
                result = "wrong";
        }
        Map<String, Object> resultMap = new HashMap<String, Object >();
//        System.out.println("result from controller:"+result);
        resultMap.put("result", result);
        return resultMap;
    }

    @RequestMapping(value = "/reLogin")
    public String reLogin(HttpSession httpSession){
        System.out.println("我接受到了relogin请求");
        httpSession.setAttribute("currentUser","");
        return "redirect:login";
    }

    @RequestMapping(value = "/doRegister",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> doRegister(String name,String gender,String phone,String password,String email,int role){
        String result="fail";
        System.out.println("我接收到了register请求" + email + " " + password);
        User user=userService.getUserByEmail(email);
        if(user!=null)  result="emailExist";
        else{
            User u=new User();
            u.setName(name);
            u.setEmail(email);
            u.setPassword(password);
            u.setPhone(phone);
            u.setRole(0);
            u.setSex(gender);
            Date date=new Date();
            SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
            u.setCreateTime(sf.format(date));
            userService.addUser(u);
            result="success";
        }
        Map<String,Object> resultMap=new HashMap<String, Object>();
        resultMap.put("result",result);
        return resultMap;
    }

    @RequestMapping(value = "/getUserById",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getUserById(int id){
        User user=userService.getUser(id);
        String result= JSON.toJSONString(user);
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }

    @RequestMapping(value = "/getUserEmail")
    @ResponseBody
    public Map<String,Object> getUserAddress(int id){
        User user=userService.getUser(id);
        String email=user.getEmail();
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("email",email);
        return resultMap;
    }

    @RequestMapping(value = "/getUserPhone")
    @ResponseBody
    public Map<String,Object> getUserPhone(int id){
        User user=userService.getUser(id);
        String phone=user.getPhone();
        Map<String,Object> resultMap=new HashMap<String,Object>();
        resultMap.put("phone",phone);
        return resultMap;
    }

    @RequestMapping(value = "/getAllUsers")
    @ResponseBody
    public Map<String,Object> getAllUser(){
        List user_list=userService.getAllUser();
        String all_user= JSONArray.toJSONString(user_list);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("all_user",all_user);
        return resultMap;
    }

    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public Map<String,Object> updateUser(int id,String name,String sex,String email,String phone,String password,int role){
//<th>姓名</th> <th>性别</th> <th>地址</th> <th>电话</th> <th>密码</th> <th>角色</th>
        User user=userService.getUser(id);
        user.setName(name);
        user.setSex(sex);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setRole(role);
        userService.updateUser(user);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("result","success");
        return resultMap;
    }

    @RequestMapping(value = "/deleteUser")
    @ResponseBody
    public Map<String,Object> deleteUser(int id){
        userService.deleteUser(id);
        Map<String,Object> resultMap=new HashMap<String ,Object>();
        resultMap.put("result","success");
        return resultMap;
    }
}
