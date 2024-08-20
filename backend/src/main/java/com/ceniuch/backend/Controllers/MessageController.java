package com.ceniuch.backend.Controllers;

import com.ceniuch.backend.Entities.Message;
import com.ceniuch.backend.Repositories.MessageRepository;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping()
    Message createMessage(@RequestBody Message message) {
        return messageRepository.save(message);
    }
}
