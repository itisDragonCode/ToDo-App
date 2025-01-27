namespace ToDo.Infrastructure.Interfaces
{
    public class ToDoItemSearchObject : BaseSearchObject
    {
        public string? Title { get; set; }
        public bool? IsDone { get; set; }
    }
}