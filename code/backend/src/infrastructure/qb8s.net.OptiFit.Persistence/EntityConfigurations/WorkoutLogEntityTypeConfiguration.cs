using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class WorkoutLogEntityTypeConfiguration : BaseEntityTypeConfiguration<WorkoutLog>
{
    protected override void Configure(EntityTypeBuilder<WorkoutLog> builder)
    {
        builder
            .ToTable("workout_log");

        builder
            .Property(wl => wl.Order)
            .HasColumnName("order")
            .IsRequired();

        builder
            .Property(wl => wl.WorkoutId)
            .IsRequired();

        builder
            .Property(wl => wl.ExerciseId)
            .IsRequired();

        builder
            .Property(wl => wl.Notes)
            .HasMaxLength(500)
            .IsRequired(false);
        builder
            .OwnsOne(wpe => wpe.Set, set =>
            {
                set
                    .Property(s => s.Reps)
                    .HasColumnName("reps")
                    .IsRequired();
                set
                    .Property(s => s.Weight)
                    .HasColumnName("weight")
                    .IsRequired();
                set
                    .Property(s => s.Order)
                    .HasColumnName("order")
                    .IsRequired();
            });
    }
}