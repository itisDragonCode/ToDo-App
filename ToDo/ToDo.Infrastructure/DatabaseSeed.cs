
using Microsoft.EntityFrameworkCore;
using ToDo.Core;

namespace ToDo.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2025, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);
        private readonly DateTime _dateTime_second = new(2025, 11, 1, 0, 0, 0, 0, DateTimeKind.Local);

        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedToDoItems(modelBuilder);
        }

        private void SeedToDoItems(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ToDoItem>().HasData(
                  new()
                  {
                      Id = 1,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      IsDeleted = false,
                      Title = "Vacuuming living room",
                      DueDate = new DateTime(2025, 2, 25),
                      IsDone = false,
                  },
                  new()
                  {
                      Id = 2,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      IsDeleted = false,
                      Title = "Buying milk",
                      DueDate = new DateTime(2025, 2, 10),
                      IsDone = false,
                  });
        }



    }
}
