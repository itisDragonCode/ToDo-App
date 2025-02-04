using ToDo.Core;
using ToDo.Infrastructure.Interfaces;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.EntityFrameworkCore;
using System.Runtime.CompilerServices;

namespace ToDo.Infrastructure
{
    public class UsersRepository : BaseRepository<User, int, UsersSearchObject>, IUsersRepository
    {
        public UsersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<User?> ChangeEmailAsync(int userId, JsonPatchDocument jsonPatch, CancellationToken cancellationToken = default)
        {
            var user = await DbSet.FindAsync(userId);
            if (user != null)
            {
                jsonPatch.ApplyTo(user);
                return user;
            }
            return null;
        }

        public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(x => x.Email == email, cancellationToken);
        }

        public override async Task<PagedList<User>> GetPagedAsync(UsersSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(c => c.ProfilePhoto).Where(c => searchObject.FullName == null || c.FirstName.ToLower().Contains(searchObject.FullName.ToLower())
            || c.LastName.ToLower().Contains(searchObject.FullName.ToLower())).
            Where(c => searchObject.Role == null || searchObject.Role == c.Role)
            .Where(c => searchObject.IsActive == null || c.IsActive == searchObject.IsActive)
            .ToPagedListAsync(searchObject, cancellationToken);
        }


        public async override Task<ReportInfo<User>> GetCountAsync(UsersSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.FullName == null || c.FirstName.ToLower().Contains(searchObject.FullName.ToLower())
            || c.LastName.ToLower().Contains(searchObject.FullName.ToLower())).
            Where(c => searchObject.Role == null || searchObject.Role == c.Role)
            .Where(c => searchObject.IsActive == null || c.IsActive == searchObject.IsActive)
            .ToReportInfoAsync(searchObject, cancellationToken);
        }
    }
}
