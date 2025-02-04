
using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Infrastructure
{
    public class ToDoItemsRepository : BaseRepository<ToDoItem, int, ToDoItemSearchObject>, IToDoItemsRepository
    {
        public ToDoItemsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async override Task<PagedList<ToDoItem>> GetPagedAsync(ToDoItemSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.IsDone == null || c.IsDone == searchObject.IsDone)
                .Where(c => searchObject.Title == null || c.Title.ToLower().Contains(searchObject.Title.ToLower()))
                .Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                 .ToPagedListAsync(searchObject, cancellationToken);
        }

        public async override Task<ReportInfo<ToDoItem>> GetCountAsync(ToDoItemSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.IsDone == null || c.IsDone == searchObject.IsDone)
                .Where(c => searchObject.Title == null || c.Title.ToLower().Contains(searchObject.Title.ToLower()))
                 .Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                .ToReportInfoAsync(searchObject, cancellationToken);
        }
    }
}
