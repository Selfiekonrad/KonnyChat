package com.ceniuch.backend.Controllers;

import com.ceniuch.backend.Entities.Chat;
import com.ceniuch.backend.Repositories.ChatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/chat")
@CrossOrigin(origins = "*")
public class ChatController {
    private final ChatRepository chatRepository;

    @Autowired
    public ChatController(ChatRepository chatRepository) {
        this.chatRepository = chatRepository;
    }

    @GetMapping("/{personOneId}/{personTwoId}")
    Chat findChatBetweenPersonOneAndPersonTwo(@PathVariable int personOneId, @PathVariable int personTwoId) {
       return chatRepository.findChatBetweenPersonOneAndPersonTwo(personOneId, personTwoId);
    }
}
