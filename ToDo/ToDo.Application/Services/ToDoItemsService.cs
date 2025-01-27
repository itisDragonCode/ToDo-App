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
    }
}
