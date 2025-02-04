
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces
{
    public class UsersSearchObject : BaseSearchObject
    {
        public string? FullName { get; set; }
        public Role? Role { get; set; }
        public bool? IsActive { get; set; }
    }
}
