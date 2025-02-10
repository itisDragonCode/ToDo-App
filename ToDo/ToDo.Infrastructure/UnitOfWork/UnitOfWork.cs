
using Microsoft.EntityFrameworkCore.Storage;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Infrastructure
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly DatabaseContext _databaseContext;

        public readonly ICountriesRepository CountriesRepository;
        public readonly IPhotosRepository PhotosRepository;
        public readonly IToDoItemsRepository ToDoItemsRepository;
        public readonly IUsersRepository UsersRepository;
        public readonly IQuizzesRepository QuizsRepository;
        public readonly IQuestionsRepository QuestionsRepository;
        public readonly IAnswersRepository AnswersRepository;
        public readonly IUserQuizsRepository UserQuizsRepository;

        public UnitOfWork(
            DatabaseContext databaseContext, IToDoItemsRepository toDoItemsRepository, ICountriesRepository countriesRepository, IPhotosRepository photosRepository, IUsersRepository usersRepository, IQuizzesRepository quizsRepository, IQuestionsRepository questionsRepository, IAnswersRepository answersRepository, IUserQuizsRepository userQuizsRepository)
        {
            _databaseContext = databaseContext;

            ToDoItemsRepository = toDoItemsRepository;
            CountriesRepository = countriesRepository;
            PhotosRepository = photosRepository;
            UsersRepository = usersRepository;
            QuizsRepository = quizsRepository;
            QuestionsRepository = questionsRepository;
            AnswersRepository = answersRepository;
            UserQuizsRepository = userQuizsRepository;
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.Database.BeginTransactionAsync(cancellationToken);
        }

        public async Task CommitTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.CommitTransactionAsync(cancellationToken);
        }

        public async Task RollbackTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.RollbackTransactionAsync(cancellationToken);
        }

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.SaveChangesAsync(cancellationToken);
        }

        public void SaveChanges()
        {
            _databaseContext.SaveChanges();
        }
    }
}
