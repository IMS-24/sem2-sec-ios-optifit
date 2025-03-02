using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class ExerciseEntityTypeConfiguration : BaseEntityTypeConfiguration<Exercise>
{
    protected override void Configure(EntityTypeBuilder<Exercise> builder)
    {
        builder
            .ToTable("exercise");

        builder
            .Property(e => e.I18NCode)
            .IsRequired()
            .HasMaxLength(100);
        builder
            .HasIndex(e => e.I18NCode)
            .IsUnique();

        builder.Property(e => e.Description)
            .HasMaxLength(500);

        builder
            .HasOne(e => e.ExerciseCategory)
            .WithMany(et => et.Exercises)
            .HasForeignKey(e => e.ExerciseCategoryId);

        builder
            .HasMany(e => e.ExerciseMuscleMappings)
            .WithOne(emm => emm.Exercise)
            .HasForeignKey(emm => emm.ExerciseId);

        builder
            .HasMany(e => e.WorkoutLogs)
            .WithOne(wl => wl.Exercise)
            .HasForeignKey(wl => wl.ExerciseId);

        builder
            .HasMany(e => e.WorkoutPlanExerciseMappings)
            .WithOne(wplm => wplm.Exercise)
            .HasForeignKey(wplm => wplm.ExerciseId);


        builder
            .HasMany(e => e.GymExerciseMappings)
            .WithOne(gem => gem.Exercise)
            .HasForeignKey(gem => gem.ExerciseId);
    }
}