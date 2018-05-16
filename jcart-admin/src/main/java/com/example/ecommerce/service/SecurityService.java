package com.example.ecommerce.service;

import com.example.ecommerce.entity.User;
import com.example.ecommerce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class SecurityService {
    @Autowired
    UserRepository userRepository;

    public User findUserByEmail(String email)
    {
        return userRepository.findByEmail(email);
    }
}
