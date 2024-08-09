package com.ceniuch.backend.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class User {
    @Id
    int id;
    String name;

    public User(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public User() {

    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}