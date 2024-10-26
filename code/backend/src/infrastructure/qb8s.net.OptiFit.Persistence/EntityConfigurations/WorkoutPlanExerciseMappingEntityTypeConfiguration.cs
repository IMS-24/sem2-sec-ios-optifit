using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class WorkoutPlanExerciseMappingEntityTypeConfiguration : BaseEntityTypeConfiguration<WorkoutPlanExerciseMapping>
{
    protected override void Configure(EntityTypeBuilder<WorkoutPlanExerciseMapping> builder)
    {
        builder
            .ToTable("workout_plan_exercise_mapping");

        builder
            .Property(wpe => wpe.WorkoutPlanId)
            .IsRequired();

        builder
            .Property(wpe => wpe.ExerciseId)
            .IsRequired();

        builder.HasOne(wpe => wpe.WorkoutPlan)
            .WithMany(wp => wp.WorkoutPlanExerciseMappings)
            .HasForeignKey(wpe => wpe.WorkoutPlanId);

        builder.HasOne(wpe => wpe.Exercise)
            .WithMany(wp => wp.WorkoutPlanExerciseMappings)
            .HasForeignKey(wpe => wpe.ExerciseId);

        builder
            .OwnsMany(wpe => wpe.Sets, set =>
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