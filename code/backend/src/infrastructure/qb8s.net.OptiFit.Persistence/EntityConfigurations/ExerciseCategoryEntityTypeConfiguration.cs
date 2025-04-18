using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class ExerciseCategoryEntityTypeConfiguration : BaseEntityTypeConfiguration<ExerciseCategory>
{
    protected override void Configure(EntityTypeBuilder<ExerciseCategory> builder)
    {
        builder
            .ToTable("exercise_category");

        builder
            .Property(m => m.I18NCode)
            .IsRequired()
            .HasMaxLength(50);

        builder
            .HasIndex(m => m.I18NCode)
            .IsUnique();

        builder
            .HasMany(m => m.Exercises)
            .WithOne(mgm => mgm.ExerciseCategory)
            .HasForeignKey(mgm => mgm.ExerciseCategoryId);

        var exerciseTypes = new List<ExerciseCategory>
        {
            new()
            {
                I18NCode = "push",
                Id = Guid.Parse("92d3c7a3-bab6-4d49-afce-70ed62b7814e")
            },
            new()
            {
                I18NCode = "pull",
                Id = Guid.Parse("b4508634-2e74-49b1-88bd-01041aed3e2b")
            },
            new()
            {
                I18NCode = "legs",
                Id = Guid.Parse("353cc6f0-c36d-493b-950c-0166f6159d25")
            }
        };
        builder.HasData(exerciseTypes);
    }
}