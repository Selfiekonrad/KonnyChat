package com.ceniuch.backend.Repositories;

import com.ceniuch.backend.Entities.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Integer> {
    @Query("SELECT u FROM User u WHERE u.id != :id")
    Iterable<User> findAllWithout(@Param("id") int id);
}