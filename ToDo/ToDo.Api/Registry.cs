using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using ToDo.Api;
using ToDo.Application;
using ToDo.Infrastructure;

namespace ToDo.Api
{
    public static class Registry
    {
        public static T BindConfig<T>(this WebApplicationBuilder builder, string key) where T : class
        {
            var section = builder.Configuration.GetSection(key);
            builder.Services.Configure<T>(section);
            return section.Get<T>()!;
        }

        public static void AddMapper(this IServiceCollection services)
        {
            services.AddAutoMapper(typeof(Program), typeof(BaseProfile));
        }

        public static void AddDatabase(this IServiceCollection services, ConnectionStringConfig config)
        {
            services.AddDbContext<DatabaseContext>(options => options.UseSqlServer(config.Main));
        }
    }
}
