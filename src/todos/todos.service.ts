import { Injectable } from '@nestjs/common';
import { CreateTodoDto } from './dtos/createTodo.dto';
import { todos } from './todos.data';
import { Todo } from './schemas/todo.schema';

@Injectable()
export class TodosService {
  getAll(): Todo[] {
    return todos;
  }

  async create(dto: CreateTodoDto): Promise<Todo> {
    const newTodo: Todo = {
      name: dto.name,
      description: dto.description,
      createdAt: new Date().toISOString(),
      id: todos[todos.length - 1].id + 1,
    };

    todos.push(newTodo);

    return newTodo;
  }
}
