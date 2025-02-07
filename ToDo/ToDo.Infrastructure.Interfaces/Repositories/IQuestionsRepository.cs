
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces
{
    public interface IQuestionsRepository : IBaseRepository<Question, int, QuestionsSearchObject>
    {
    }
}
