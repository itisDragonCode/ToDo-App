namespace ToDo.Core
{
    public class Photo : BaseEntity
    {
        public string Data { get; set; } = null!;
      
        public ICollection<User> Users { get; set; } = null!;
    }
}
