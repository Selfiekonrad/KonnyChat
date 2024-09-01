package com.ceniuch.backend.Entities;

import jakarta.persistence.*;

@Entity
public class Chat {
    @Id
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

    public void setId(int id) {
        this.id = id;
    }

    public int getPersonOne() {
        return personOne;
    }

    public void setPersonOne(int personOne) {
        this.personOne = personOne;
    }

    public int getPersonTwo() {
        return personTwo;
    }

    public void setPersonTwo(int personTwo) {
        this.personTwo = personTwo;
    }
}
