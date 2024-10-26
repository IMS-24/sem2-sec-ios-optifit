using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class ExerciseMuscleGroupMappingEntityTypeConfiguration : BaseEntityTypeConfiguration<ExerciseMuscleGroupMapping>
{
    protected override void Configure(EntityTypeBuilder<ExerciseMuscleGroupMapping> builder)
    {
        builder
            .ToTable("exercise_muscle_group_mapping");

        builder
            .Property(e => e.ExerciseId)
            .IsRequired();

        builder
            .Property(e => e.MuscleGroupId)
            .IsRequired();

        builder
            .HasOne(emgm => emgm.Exercise)
            .WithMany(e => e.ExerciseMuscleGroupMappings)
            .HasForeignKey(emgm => emgm.ExerciseId);

        builder
            .HasOne(emgm => emgm.MuscleGroup)
            .WithMany(mg => mg.ExerciseMuscleGroupMappings)
            .HasForeignKey(emgm => emgm.MuscleGroupId);
    }
}