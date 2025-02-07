using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface IQuestionsService : IBaseService<int, QuestionDto, QuestionUpsertDto, QuestionsSearchObject>
    {
    }
}
