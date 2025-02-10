
using ToDo.Infrastructure.Interfaces;
using Microsoft.Extensions.DependencyInjection;
namespace ToDo.Infrastructure
{
    public static class Registry
    {
        public static void AddInfrastructure(this IServiceCollection services)
        {
            services.AddScoped<IToDoItemsRepository, ToDoItemsRepository>();
            services.AddScoped<ICountriesRepository, CountriesRepository>();
            services.AddScoped<IPhotosRepository, PhotosRepository>();
            services.AddScoped<IUsersRepository, UsersRepository>();
            services.AddScoped<IQuizzesRepository, QuizsRepository>();
            services.AddScoped<IQuestionsRepository, QuestionsRepository>();
            services.AddScoped<IAnswersRepository, AnswersRepository>();
            services.AddScoped<IUserQuizsRepository, UserQuizsRepository>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
        }
    }
}
