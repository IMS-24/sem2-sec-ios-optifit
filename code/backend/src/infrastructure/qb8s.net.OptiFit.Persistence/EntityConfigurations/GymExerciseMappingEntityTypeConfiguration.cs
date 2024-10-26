using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class GymExerciseMappingEntityTypeConfiguration : BaseEntityTypeConfiguration<GymExerciseMapping>
{
    protected override void Configure(EntityTypeBuilder<GymExerciseMapping> builder)
    {
        builder
            .ToTable("gym_exercise_mapping");

        builder
            .Property(g => g.GymId)
            .IsRequired();

        builder
            .Property(g => g.ExerciseId)
            .IsRequired();

        builder
            .Property(g => g.IsAvailable)
            .IsRequired();

        builder
            .Property(g => g.Notes)
            .HasMaxLength(500);
    }
}