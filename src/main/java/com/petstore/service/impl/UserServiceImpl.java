package com.petstore.service.impl;

import com.petstore.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petstore.po.User;
import com.petstore.po.UserExample;
import com.petstore.service.UserService;

import java.util.List;
/*
    User com.petstore.service 的实现类
 */
@Service("UserService")
public class UserServiceImpl implements UserService{
    @Autowired
    private UserMapper userMapper;

    @Override
    public User getUser(int userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public User getUserByEmail(String email) {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andEmailEqualTo(email);
//        criteria.andEmailIsNotNull();
        if(userMapper.selectByExample(userExample).size()>=1){
            return userMapper.selectByExample(userExample).get(0);
        }else{
            return null;
        }
    }

    @Override
    public void addUser(User user) {
        userMapper.insertSelective(user);
    }

    @Override
    public boolean deleteUser(int id) {
        return userMapper.deleteByPrimaryKey(id)>0;
    }

    @Override
    public boolean updateUser(User user) {
       return userMapper.updateByPrimaryKeySelective(user)>0;
    }

    @Override
    public List<User> getAllUser() {
        UserExample example=new UserExample();
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andIdIsNotNull();
        example.setOrderByClause("id asc");
        List<User>list=userMapper.selectByExample(example);
        return list;
    }
}
