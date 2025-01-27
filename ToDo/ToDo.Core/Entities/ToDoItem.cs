
namespace ToDo.Core
{
    public class ToDoItem : BaseEntity
    {
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public DateTime DueDate { get; set; }
        public bool IsDone { get; set; }

    }
}
