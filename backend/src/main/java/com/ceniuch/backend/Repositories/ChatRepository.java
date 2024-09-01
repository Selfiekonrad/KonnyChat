package com.ceniuch.backend.Repositories;

import com.ceniuch.backend.Entities.Chat;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface ChatRepository extends CrudRepository<Chat, Integer> {
    @Query("SELECT c FROM Chat c WHERE (c.personOne = :personOneId AND c.personTwo = :personTwoId) OR (c.personOne = :personTwoId AND c.personTwo = :personOneId)")
    Chat findChatBetweenPersonOneAndPersonTwo(@Param("personOneId") int personOneId, @Param("personTwoId") int personTwoId);

    Iterable<Chat> findChatsByPersonOneOrPersonTwo(int personOne, int personTwo);
}
