using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class GymEntityTypeConfiguration : BaseEntityTypeConfiguration<Gym>
{
    protected override void Configure(EntityTypeBuilder<Gym> builder)
    {
        builder
            .ToTable("gym");

        builder
            .Property(x => x.Name)
            .IsRequired()
            .HasMaxLength(20);

        builder
            .Property(x => x.Address)
            .HasMaxLength(100)
            .IsRequired(false);

        builder
            .Property(x => x.City)
            .HasMaxLength(50)
            .IsRequired(false);

        builder
            .Property(x => x.ZipCode)
            .IsRequired(false);

        builder
            .Property(g => g.DeletedAtUtc)
            .IsRequired(false);

        builder
            .HasMany(g => g.Workouts)
            .WithOne(w => w.Gym)
            .HasForeignKey(w => w.GymId);
    }
}