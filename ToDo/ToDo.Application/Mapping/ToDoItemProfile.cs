using System.Data;
using ToDo.Core;

namespace ToDo.Application
{
    public class ToDoItemProfile : BaseProfile
    {
        public ToDoItemProfile()
        {
            CreateMap<ToDoItemDto, ToDoItem>().ReverseMap();

            CreateMap<ToDoItemUpsertDto, ToDoItem>();

        }
    }
}
