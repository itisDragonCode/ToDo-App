using ToDo.Api;
using ToDo.Api;
using ToDo.Application;
using ToDo.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

var kestrelHost = Environment.GetEnvironmentVariable("Host_Type");

if (kestrelHost != null)
{
    builder.WebHost.ConfigureKestrel(config =>
    {
        config.ListenAnyIP(5002);
    });
}

var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle

builder.Services.AddMapper();
builder.Services.AddValidators();
builder.Services.AddApplication();
builder.Services.AddInfrastructure();
builder.Services.AddDatabase(connectionStringConfig);
builder.Services.AddResponseCaching();
builder.Services.AddSignalR();

builder.Services.AddCors(options => options.AddPolicy(
                name: "CorsPolicy",
                builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()
            ));

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("CorsPolicy");
app.UseHttpsRedirection();
app.UseResponseCaching();
app.UseAuthorization();
app.MapControllers();

app.Run();
