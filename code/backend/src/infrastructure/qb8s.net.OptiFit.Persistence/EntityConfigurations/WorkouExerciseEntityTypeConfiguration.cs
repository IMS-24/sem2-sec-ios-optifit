using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class WorkouExerciseEntityTypeConfiguration : BaseEntityTypeConfiguration<WorkoutExercise>
{
    protected override void Configure(EntityTypeBuilder<WorkoutExercise> builder)
    {
        builder
            .ToTable("workout_exercise");

        builder
            .Property(workoutExercise => workoutExercise.Order)
            .HasColumnName("order")
            .IsRequired();

        builder
            .Property(workoutExercise => workoutExercise.WorkoutId)
            .IsRequired();

        builder
            .Property(workoutExercise => workoutExercise.ExerciseId)
            .IsRequired();

        builder
            .Property(workoutExercise => workoutExercise.Notes)
            .HasMaxLength(500)
            .IsRequired(false);
    }
}