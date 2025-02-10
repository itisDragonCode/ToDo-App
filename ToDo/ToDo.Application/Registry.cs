using ToDo.Application.Interfaces;
using ToDo.Application.Validators;
using ToDo.Core;
using FluentValidation;
using Microsoft.Extensions.DependencyInjection;

namespace ToDo.Application
{
    public static class Registry
    {
        public static void AddApplication(this IServiceCollection services)
        {
            services.AddScoped<IToDoItemsService, ToDoItemsService>();
            services.AddScoped<ICountriesService, CountriesService>();
            services.AddScoped<IPhotosService, PhotosService>();
            services.AddScoped<IUsersService, UsersService>();
            services.AddScoped<IQuizzesService, QuizsService>();
            services.AddScoped<IQuestionsService, QuestionsService>();
            services.AddScoped<IAnswersService, AnswersService>();
            services.AddScoped<IUserQuizsService, UserQuizsService>();
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<ToDoItemUpsertDto>, ToDoItemValidator>();
            services.AddScoped<IValidator<CountryUpsertDto>, CountryValidator>();
            services.AddScoped<IValidator<PhotoUpsertDto>, PhotoValidator>();
            services.AddScoped<IValidator<UserUpsertDto>, UserValidator>();
            services.AddScoped<IValidator<UserChangePasswordDto>, UserPasswordValidator>();
            services.AddScoped<IValidator<QuizUpsertDto>, QuizValidator>();
            services.AddScoped<IValidator<QuestionUpsertDto>, QuestionValidator>();
            services.AddScoped<IValidator<AnswerUpsertDto>, AnswerValidator>();
            services.AddScoped<IValidator<UserQuizUpsertDto>, UserQuizValidator>();
        }
    }
}
