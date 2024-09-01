package com.ceniuch.backend.Repositories;

import com.ceniuch.backend.Entities.Message;
import org.springframework.data.repository.CrudRepository;

public interface MessageRepository extends CrudRepository<Message, Integer> {

    Iterable<Message> findAllByChatId(int chatId);

    Message findTopByChatIdOrderByIdDesc(int chatId);
}
