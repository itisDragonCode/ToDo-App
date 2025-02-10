
using ToDo.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace ToDo.Infrastructure
{
    public class UserQuizConfiguration : BaseConfiguration<UserQuiz>
    {
        public override void Configure(EntityTypeBuilder<UserQuiz> builder)
        {
            base.Configure(builder);

            builder.HasOne(e => e.Quiz)
                    .WithMany(e => e.Users)
                    .HasForeignKey(e => e.QuizId)
                    .IsRequired();


            builder.HasOne(e => e.User)
                   .WithMany(e => e.Quizzes)
                   .HasForeignKey(e => e.UserId)
                   .OnDelete(DeleteBehavior.NoAction);

            builder.Property(e => e.Percentage)
                             .IsRequired();
        }
    }
}
