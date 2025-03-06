using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class WorkoutSetEntityTypeConfiguration : BaseEntityTypeConfiguration<WorkoutSet>
{
    protected override void Configure(EntityTypeBuilder<WorkoutSet> builder)
    {
        builder
            .ToTable("workout_set");

        builder
            .Property(workoutSet => workoutSet.Id)
            .IsRequired();

        builder
            .Property(workoutSet => workoutSet.Reps)
            .IsRequired();

        builder
            .Property(workoutSet => workoutSet.Weight)
            .IsRequired();
    }
}