package com;

import com.petstore.po.User;
import com.petstore.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class testEmail {

    @Autowired
    private UserService userService;
    User user=new User();

    @Test
    public void testUserEmail(){
        if(userService.getUserByEmail("11213@qq.com")!=null)
            System.out.println(user.getName());
        else
            System.out.println("null");
    }

    @Test
    public void testUser(){
        user=userService.getUser(100);
        System.out.println(user.getName());
    }
}
