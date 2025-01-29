using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface IToDoItemsService : IBaseService<int, ToDoItemDto, ToDoItemUpsertDto, ToDoItemSearchObject>
    {
        Task ChangeDoneStatus(int notificationId, CancellationToken cancellationToken = default);
    }

}
