using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface IUserQuizsService : IBaseService<int, UserQuizDto, UserQuizUpsertDto, UserQuizsSearchObject>
    {
    }
}
