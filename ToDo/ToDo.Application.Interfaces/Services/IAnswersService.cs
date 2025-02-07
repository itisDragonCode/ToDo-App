using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface IAnswersService : IBaseService<int, AnswerDto, AnswerUpsertDto, AnswersSearchObject>
    {
    }
}
