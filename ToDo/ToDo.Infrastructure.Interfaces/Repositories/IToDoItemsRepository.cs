
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces 
{
    public interface IToDoItemsRepository : IBaseRepository<ToDoItem, int, ToDoItemSearchObject>
    {
    }
}
