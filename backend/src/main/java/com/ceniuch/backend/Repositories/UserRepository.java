package com.ceniuch.backend.Repositories;

import com.ceniuch.backend.Entities.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {}