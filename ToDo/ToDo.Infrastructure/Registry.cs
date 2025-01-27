
using ToDo.Infrastructure.Interfaces;
using Microsoft.Extensions.DependencyInjection;
namespace ToDo.Infrastructure
{
    public static class Registry
    {
        public static void AddInfrastructure(this IServiceCollection services)
        {
            services.AddScoped<IToDoItemsRepository, ToDoItemsRepository>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
        }
    }
}
