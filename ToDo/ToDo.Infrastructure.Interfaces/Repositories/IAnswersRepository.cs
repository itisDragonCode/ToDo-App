
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces
{
    public interface IAnswersRepository : IBaseRepository<Answer, int, AnswersSearchObject>
    {
    }
}
