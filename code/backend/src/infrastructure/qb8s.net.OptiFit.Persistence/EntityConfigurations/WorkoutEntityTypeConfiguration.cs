using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class WorkoutEntityTypeConfiguration : BaseEntityTypeConfiguration<Workout>
{
    protected override void Configure(EntityTypeBuilder<Workout> builder)
    {
        builder
            .ToTable("workout");

        builder
            .Property(w => w.UserId)
            .IsRequired();

        builder.Property(w => w.StartAtUtc)
            .IsRequired();

        builder.Property(w => w.Description)
            .HasMaxLength(500)
            .IsRequired();

        builder.Property(w => w.Notes)
            .HasMaxLength(200)
            .IsRequired(false);

        builder
            .HasMany(w => w.WorkoutExercises)
            .WithOne(wl => wl.Workout)
            .HasForeignKey(wl => wl.WorkoutId);
    }
}