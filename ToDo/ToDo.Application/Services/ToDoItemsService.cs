using AutoMapper;
using FluentValidation;

using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application
{
    public class ToDoItemsService : BaseService<ToDoItem, ToDoItemDto, ToDoItemUpsertDto, ToDoItemSearchObject, IToDoItemsRepository>, IToDoItemsService
    {
        public ToDoItemsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ToDoItemUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

        public async Task ChangeDoneStatus(int notificationId, CancellationToken cancellationToken = default)
        {
            var toDoItem = await CurrentRepository.GetByIdAsync(notificationId);

            if (toDoItem == null)
                throw new Exception("To Do item not found");

            toDoItem.IsDone = !toDoItem.IsDone;

            CurrentRepository.Update(toDoItem);
            await UnitOfWork.SaveChangesAsync();


        }
    }
}
