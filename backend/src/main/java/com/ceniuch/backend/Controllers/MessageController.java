package com.ceniuch.backend.Controllers;

import com.ceniuch.backend.Entities.Message;
import com.ceniuch.backend.Repositories.MessageRepository;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/messages")
@CrossOrigin(origins = "*")
public class MessageController {
    private final MessageRepository messageRepository;

    public MessageController(MessageRepository messageRepository) {
        this.messageRepository = messageRepository;
    }

    @GetMapping("/{chatId}")
    Iterable<Message> getAllMessagesByChatId(@PathVariable int chatId) {
       return messageRepository.findAllByChatId(chatId);
    }

    @GetMapping("/lastMessage/{chatId}")
    Message getLastMessageByChatId(@PathVariable int chatId) {
        return messageRepository.findTopByChatIdOrderByIdDesc(chatId);
    }

    @PostMapping()
    Message createMessage(@RequestBody Message message) {
        message.setTimeSent(Timestamp.valueOf(LocalDateTime.now()));
        return messageRepository.save(message);
    }
}
