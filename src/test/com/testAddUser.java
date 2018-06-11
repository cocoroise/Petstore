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
public class testAddUser {
    @Autowired
    private UserService userService;

    @Test
    public void testUser(){
        User user=new User();
        user.setName("xc");
        user.setSex("女");
        user.setRole(0);
        user.setEmail("12233@qq.com");
        user.setPassword("111111");
        user.setPhone("123342342");
        userService.addUser(user);
    }
}
