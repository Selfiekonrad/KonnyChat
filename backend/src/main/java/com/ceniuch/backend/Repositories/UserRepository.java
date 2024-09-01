package com.ceniuch.backend.Repositories;

import com.ceniuch.backend.Entities.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Integer> {
    @Query("SELECT u FROM User u WHERE u.id != :id")
    Iterable<User> findAllWithout(@Param("id") int id);

    @Query("SELECT u.id FROM User u WHERE u.name = :name")
    int findUserIdByName(@Param("name") String name);

    @Query("SELECT u FROM User u WHERE u.id <> :userId AND u.id NOT IN (" +
            "SELECT CASE WHEN c.personOne = :userId THEN c.personTwo ELSE c.personOne END " +
            "FROM Chat c WHERE c.personOne = :userId OR c.personTwo = :userId)")
    Iterable<User> findAllWithoutAChatWithUser(@Param("userId") int userId);

    boolean existsUserByNameAndPassword(String name, String password);
}