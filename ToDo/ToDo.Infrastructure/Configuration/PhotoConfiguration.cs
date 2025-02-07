using ToDo.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace ToDo.Infrastructure
{
    public class PhotoConfiguration : BaseConfiguration<Photo>
    {
        public override void Configure(EntityTypeBuilder<Photo> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Data)
                   .IsRequired();
           
        }
    }
}
