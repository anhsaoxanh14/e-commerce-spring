package com.example.ecommerce.service;

import com.example.ecommerce.entity.AuthenticatedUser;
import com.example.ecommerce.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class CustomUserDetailsService implements UserDetailsService
{
    @Autowired
    private SecurityService securityService;

    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        User user = securityService.findUserByEmail(userName);
        if(user == null){
            throw new UsernameNotFoundException("Email "+userName+" not found");
        }
        return new AuthenticatedUser(user);
    }
}
