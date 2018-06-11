package com.petstore.service;


import org.springframework.stereotype.Service;
import com.petstore.po.User;

import java.util.List;

public interface UserService {
    public User getUser(int userId);

    public User getUserByEmail(String email);

    public void addUser(User user);

    public boolean deleteUser(int id);

    public boolean updateUser(User user);

    public List<User> getAllUser();
}
