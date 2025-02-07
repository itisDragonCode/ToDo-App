namespace ToDo.Core
{
    public class ToDoItemDto : BaseDto
    {
        public string Title { get; set; } = null!;
        public string? Description { get; set; } = null!;
        public DateTime DueDate { get; set; }
        public bool IsDone { get; set; }

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
