
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces
{
    public interface IQuizzesRepository : IBaseRepository<Quiz, int, QuizzesSearchObject>
    {
        Task<PagedList<Quiz>> GetActiveQuizzes(QuizzesSearchObject quizzesSearchObject, CancellationToken cancellationToken = default);
        Task<string> SeedQuizData(CancellationToken cancellationToken = default);
    }
}
