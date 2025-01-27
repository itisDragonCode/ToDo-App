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
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<ToDoItemUpsertDto>, ToDoItemValidator>();
        }
    }
}
