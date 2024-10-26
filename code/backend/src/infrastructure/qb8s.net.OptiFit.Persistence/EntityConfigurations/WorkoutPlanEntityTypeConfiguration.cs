using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class WorkoutPlanEntityTypeConfiguration : BaseEntityTypeConfiguration<WorkoutPlan>
{
    protected override void Configure(EntityTypeBuilder<WorkoutPlan> builder)
    {
        builder
            .ToTable("workout_plan");

        builder
            .Property(wp => wp.UserId)
            .IsRequired();

        builder
            .Property(wp => wp.Name)
            .HasMaxLength(100)
            .IsRequired();

        builder
            .Property(wp => wp.Description)
            .HasMaxLength(500);

        builder
            .HasMany(wp => wp.WorkoutPlanExerciseMappings)
            .WithOne(w => w.WorkoutPlan)
            .HasForeignKey(w => w.WorkoutPlanId);
    }
}