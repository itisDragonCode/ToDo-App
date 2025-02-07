using AutoMapper;
using FluentValidation;

using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application
{
    public class QuizsService : BaseService<Quiz, QuizDto, QuizUpsertDto, QuizzesSearchObject, IQuizzesRepository>, IQuizzesService
    {
        private readonly IQuestionsService _questionsService;

        public QuizsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<QuizUpsertDto> validator, IPhotosService photosService, IQuestionsService questionsService) : base(mapper, unitOfWork, validator)
        {
            _questionsService = questionsService;
        }

        public async Task<PagedList<QuizDto>> GetActiveQuizzes(QuizzesSearchObject quizzesSearchObject, CancellationToken cancellationToken = default)
        {
            var activeQuizzes = await CurrentRepository.GetActiveQuizzes(quizzesSearchObject, cancellationToken);

            return Mapper.Map<PagedList<QuizDto>>(activeQuizzes);
        }

        public async Task<string> SeedQuizData(CancellationToken cancellationToken = default)
        {
            var seedResult = await CurrentRepository.SeedQuizData();

            return seedResult;
        }
    }
}
