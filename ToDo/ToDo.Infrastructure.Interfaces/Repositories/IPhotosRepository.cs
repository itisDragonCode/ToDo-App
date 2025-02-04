
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces
{
    public interface IPhotosRepository : IBaseRepository<Photo, int, BaseSearchObject>
    {
    }
}
