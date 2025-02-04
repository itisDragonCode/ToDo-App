
using Microsoft.EntityFrameworkCore;
using ToDo.Core;
using static System.Net.Mime.MediaTypeNames;

namespace ToDo.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2025, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);
        private readonly DateTime _dateTime_second = new(2025, 11, 1, 0, 0, 0, 0, DateTimeKind.Local);

        string image = "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";

        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedToDoItems(modelBuilder);
            SeedCountries(modelBuilder);
            SeedPhotos(modelBuilder);
            SeedUsers(modelBuilder);
        }

      
        private void SeedCountries(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>().HasData(
                new()
                {
                    Id = 1,
                    Name = "Bosnia and Herzegovina",
                    Abbreviation = "BIH",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 2,
                    Name = "Germany",
                    Abbreviation = "GER",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 3,
                    Name = "France",
                    Abbreviation = "FRA",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 4,
                    Name = "Great Britain",
                    Abbreviation = "GRB",
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
        }

        private void SeedPhotos(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Photo>().HasData(
                 new()
                 {
                     Id = 1,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     Data = image

                 },
            new()
            {
                Data = image,
                Id = 2,
                CreatedAt = _dateTime,
                ModifiedAt = null,
            });
        }

        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                 new()
                 {
                     Id = 1,
                     FirstName = "Admin1",
                     LastName = "LatnameA1",
                     Email = "admin1@gmail.com",
                     Role = Role.Administrator,
                     Gender = Gender.Male,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "134146161",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 },
                 new()
                 {
                     Id = 2,
                     FirstName = "User2",
                     LastName = "LastnameU2",
                     Email = "user2@gmail.com",
                     Role = Role.Administrator,
                     Gender = Gender.Female,
                     PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                     PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                     PhoneNumber = "4644644868",
                     BirthDate = new DateTime(1992, 4, 23),
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     CountryId = 1

                 });
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
                      UserId = 2,
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
                      UserId = 2,
                  });
        }


    }
}
