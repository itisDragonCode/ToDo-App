using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface IPhotosService : IBaseService<int, PhotoDto, PhotoUpsertDto, BaseSearchObject>
    {
        
    }
}
