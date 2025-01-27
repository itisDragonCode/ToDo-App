using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using ToDo.Application;
using ToDo.Application.Interfaces;
using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Api.Controllers
{
    public class ToDoItemController : BaseCrudController<ToDoItemDto, ToDoItemUpsertDto, ToDoItemSearchObject, IToDoItemsService>
    {
        public ToDoItemController(IToDoItemsService service, ILogger<ToDoItemController> logger) : base(service, logger)
        {
        }
       
    }
}
