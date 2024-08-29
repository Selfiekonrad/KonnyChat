package com.ceniuch.backend.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

import java.sql.Timestamp;

@Entity
public class Message {
    @Id
    int id;
    int sender;
    int receiver;
    int chatId;
    String messageText;
    Timestamp timeSent;

    public Message() {

    }

    public Message(int id, int sender, int receiver, int chatId,
                   String messageText, Timestamp timeSent) {
        this.id = id;
        this.sender = sender;
        this.receiver = receiver;
        this.chatId = chatId;
        this.messageText = messageText;
        this.timeSent = timeSent;
    }

    public int getId() {
        return id;
    }

    public int getSender() {
        return sender;
    }

    public int getReceiver() {
        return receiver;
    }

    public int getChatId() {
        return chatId;
    }

    public String getMessageText() {
        return messageText;
    }

    public Timestamp getTimeSent() {
        return timeSent;
    }

    public void setTimeSent(Timestamp timeSent) {
        this.timeSent = timeSent;
    }
}
