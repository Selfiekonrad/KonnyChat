package com.ceniuch.backend.Entities;

import jakarta.persistence.*;

@Entity
public class Chat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    int personOne;
    int personTwo;

    public Chat(int id, int personOne, int personTwo) {
        this.id = id;
        this.personOne = personOne;
        this.personTwo = personTwo;
    }

    public Chat() {

    }

    public int getId() {
        return id;
    }

    public int getPersonOne() {
        return personOne;
    }

    public int getPersonTwo() {
        return personTwo;
    }
}
