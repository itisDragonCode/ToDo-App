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
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<ToDoItemUpsertDto>, ToDoItemValidator>();
            services.AddScoped<IValidator<CountryUpsertDto>, CountryValidator>();
            services.AddScoped<IValidator<PhotoUpsertDto>, PhotoValidator>();
            services.AddScoped<IValidator<UserUpsertDto>, UserValidator>();
            services.AddScoped<IValidator<UserChangePasswordDto>, UserPasswordValidator>();

        }
    }
}
