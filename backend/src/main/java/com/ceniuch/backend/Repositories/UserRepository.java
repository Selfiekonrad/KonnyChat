package com.ceniuch.backend.Repositories;

import com.ceniuch.backend.Entities.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Integer> {
    @Query("SELECT u FROM User u WHERE u.id != :id")
    Iterable<User> findAllWithout(@Param("id") int id);

    boolean existsUserByNameAndPassword(String name, String password);

    @Query("SELECT u.id FROM User u WHERE u.name = :name")
    int findUserIdByName(@Param("name") String name);
}