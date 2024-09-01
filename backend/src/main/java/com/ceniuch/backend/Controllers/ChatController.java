package com.ceniuch.backend.Controllers;

import com.ceniuch.backend.Entities.Chat;
import com.ceniuch.backend.Entities.User;
import com.ceniuch.backend.Repositories.ChatRepository;
import com.ceniuch.backend.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/chat")
@CrossOrigin(origins = "*")
public class ChatController {
    private final ChatRepository chatRepository;
    private final UserRepository userRepository;

    @Autowired
    public ChatController(ChatRepository chatRepository, UserRepository userRepository) {
        this.userRepository = userRepository;
        this.chatRepository = chatRepository;
    }

    @GetMapping("/{personOneId}/{personTwoId}")
    Chat findChatBetweenPersonOneAndPersonTwo(@PathVariable int personOneId, @PathVariable int personTwoId) {
       return chatRepository.findChatBetweenPersonOneAndPersonTwo(personOneId, personTwoId);
    }

    @GetMapping("/allChatsFromUserId/{userId}")
    Iterable<Chat> findAllChatsFromUserId(@PathVariable int userId) {
        return chatRepository.findChatsByPersonOneOrPersonTwo(userId, userId);
    }

    @PostMapping("/newChat")
    Object createNewChat(@RequestBody Chat chat) {
        Optional<User> personOne = userRepository.findById(chat.getPersonOne());
        Optional<User> personTwo = userRepository.findById(chat.getPersonTwo());

        if (personOne.isEmpty() || personTwo.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("One or both users do not exist.");
        }

        // Proceed with saving the chat
        return chatRepository.save(chat);
    }
}
