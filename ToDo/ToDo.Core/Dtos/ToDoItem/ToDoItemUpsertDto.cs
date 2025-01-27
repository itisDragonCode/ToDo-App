namespace ToDo.Core
{
    public class ToDoItemUpsertDto : BaseUpsertDto
    {
        public string Title { get; set; } = null!;
        public string? Description { get; set; } = null!;
        public DateTime DueDate { get; set; }
        public bool IsDone { get; set; }
    }
}
