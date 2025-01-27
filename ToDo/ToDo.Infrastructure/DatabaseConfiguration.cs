﻿
using ToDo.Core;
using Microsoft.EntityFrameworkCore;


namespace ToDo.Infrastructure
{
    public partial class DatabaseContext
    {
        public override int SaveChanges()
        {
            ModifyTimestamps();

            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            ModifyTimestamps();

            return base.SaveChangesAsync(cancellationToken);
        }

        private void ModifyTimestamps()
        {
            foreach (var entry in ChangeTracker.Entries())
            {
                var entity = (BaseEntity)entry.Entity;

                if (entry.State == EntityState.Modified) entity.ModifiedAt = DateTime.Now;
                else if (entry.State == EntityState.Added) entity.CreatedAt = DateTime.Now;
            }
        }

        private void ApplyConfigurations(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(BaseConfiguration<>).Assembly);
        }
    }
}
