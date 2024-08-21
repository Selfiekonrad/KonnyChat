package com.ceniuch.backend.Controllers;

import com.ceniuch.backend.Entities.User;
import com.ceniuch.backend.Repositories.UserRepository;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "*")
public class UserController {
    private final UserRepository userRepository;

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping
    Iterable<User> getUsers() {
        return userRepository.findAll();
    }

    @GetMapping("/getUserIdFromName/{name}")
    int getUserFromName(@PathVariable String name) {
        return userRepository.findUserIdByName(name);
    }

    @GetMapping("/without/{id}")
    Iterable<User> getUsersWithout(@PathVariable int id) {
        return userRepository.findAllWithout(id);
    }

    @GetMapping("/{id}")
    User getUser(@PathVariable int id) {
        return userRepository.findById(id).orElse(null);
    }

    @PostMapping()
    User createUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @GetMapping("/login/{name}/{password}")
    boolean existsUserByNameAndPassword(@PathVariable String name, @PathVariable String password) {
        return userRepository.existsUserByNameAndPassword(name, password);
    }
}