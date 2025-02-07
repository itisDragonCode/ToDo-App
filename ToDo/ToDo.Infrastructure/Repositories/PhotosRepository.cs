
using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Infrastructure
{
    public class PhotosRepository : BaseRepository<Photo, int, BaseSearchObject>, IPhotosRepository
    {
        public PhotosRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
