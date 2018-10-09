package io.github.kanedafromparis.prez.fabric8.dmp.todo;

import java.util.List;
import org.springframework.data.repository.CrudRepository;

public interface TodoItemRepository extends CrudRepository<TodoItem, Long> {    
    
        List<TodoItem> findByName(String name);
    
}
