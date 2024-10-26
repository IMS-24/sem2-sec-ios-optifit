using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class ExerciseMuscleMappingEntityTypeConfiguration : BaseEntityTypeConfiguration<ExerciseMuscleMapping>
{
    protected override void Configure(EntityTypeBuilder<ExerciseMuscleMapping> builder)
    {
        builder
            .ToTable("exercise_muscle_mapping");

        builder
            .Property(e => e.ExerciseId)
            .IsRequired();

        builder
            .Property(e => e.MuscleId)
            .IsRequired();

        builder
            .HasOne(em => em.Exercise)
            .WithMany(e => e.ExerciseMuscleMappings)
            .HasForeignKey(em => em.ExerciseId);

        builder
            .HasOne(em => em.Muscle)
            .WithMany(m => m.ExerciseMuscleMappings)
            .HasForeignKey(em => em.MuscleId);
    }
}