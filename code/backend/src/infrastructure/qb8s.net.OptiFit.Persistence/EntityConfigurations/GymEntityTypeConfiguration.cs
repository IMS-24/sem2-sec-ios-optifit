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
            .HasMaxLength(100);

        builder
            .Property(x => x.Address)
            .HasMaxLength(100)
            .IsRequired(false);

        builder
            .Property(x => x.City)
            .HasMaxLength(100)
            .IsRequired(false);

        builder
            .Property(x => x.ZipCode)
            .HasMaxLength(10)
            .IsRequired(false);

        builder
            .Property(g => g.DeletedAtUtc)
            .IsRequired(false);

        builder
            .HasMany(x => x.GymExerciseMappings)
            .WithOne(x => x.Gym)
            .HasForeignKey(x => x.GymId);

        builder
            .HasMany(g => g.Workouts)
            .WithOne(w => w.Gym)
            .HasForeignKey(w => w.GymId);
    }
}