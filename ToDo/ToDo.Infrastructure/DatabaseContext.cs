using ToDo.Core;
using Microsoft.EntityFrameworkCore;

namespace ToDo.Infrastructure
{
    public partial class DatabaseContext :DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> context):base(context) { }


        //Entities
        public DbSet<ToDoItem> ToDoItems { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            SeedData(modelBuilder);
            ApplyConfigurations(modelBuilder);
        }
    }
}
