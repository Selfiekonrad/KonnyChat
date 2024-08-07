package com.ceniuch.backend.Controllers;

import com.ceniuch.backend.Entities.User;
import com.ceniuch.backend.Repositories.UserRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/users")
public class UserController {
    private final UserRepository userRepository;

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping
    Iterable<User> getUsers() {
        return userRepository.findAll();
    }
}