package com.ceniuch.backend.Service;

import com.ceniuch.backend.Entities.User;
import com.ceniuch.backend.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public boolean isPasswordCorrect(User user, String password) {
        return user.getPassword().equals(password);
    }
}
