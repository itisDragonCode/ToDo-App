using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface IQuizzesService : IBaseService<int, QuizDto, QuizUpsertDto, QuizzesSearchObject>
    {
        Task<PagedList<QuizDto>> GetActiveQuizzes(QuizzesSearchObject quizzesSearchObject, CancellationToken cancellationToken = default);
        Task<string> SeedQuizData(CancellationToken cancellationToken = default);
    }
}
