using ToDo.Core;
using ToDo.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ToDoItemConfiguration : BaseConfiguration<ToDoItem>
{
    public override void Configure(EntityTypeBuilder<ToDoItem> builder)
    {
        base.Configure(builder);

        builder.Property(ac => ac.Title)
               .IsRequired()
               .HasMaxLength(40);

        builder.Property(ac => ac.Description)
               .HasMaxLength(2000)
               .IsRequired(false);

        builder.Property(ac => ac.DueDate)
              .IsRequired();

        builder.Property(ac => ac.IsDeleted)
               .IsRequired();

        builder.HasOne(e => e.User)
                 .WithMany(e => e.ToDoItems)
                 .HasForeignKey(e => e.UserId)
                 .IsRequired();
    }
}
