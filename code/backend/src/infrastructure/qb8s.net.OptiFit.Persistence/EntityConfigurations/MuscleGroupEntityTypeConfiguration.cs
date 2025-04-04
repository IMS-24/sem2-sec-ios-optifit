using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class MuscleGroupEntityTypeConfiguration : BaseEntityTypeConfiguration<MuscleGroup>
{
    protected override void Configure(EntityTypeBuilder<MuscleGroup> builder)
    {
        builder
            .ToTable("muscle_group");

        builder
            .Property(m => m.I18NCode)
            .IsRequired()
            .HasMaxLength(50);

        builder
            .HasIndex(m => m.I18NCode)
            .IsUnique();

        builder
            .HasMany(mg => mg.MuscleGroupMappings)
            .WithOne(mgm => mgm.MuscleGroup)
            .HasForeignKey(mgm => mgm.MuscleGroupId);


        var muscleGroups = new List<MuscleGroup>
        {
            new()
            {
                Id = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11"),
                I18NCode = "chest"
            },
            new()
            {
                Id = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92"),
                I18NCode = "back"
            },
            new()
            {
                Id = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"),
                I18NCode = "shoulders"
            },
            new()
            {
                Id = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"),
                I18NCode = "arms"
            },
            new()
            {
                Id = Guid.Parse("ca487800-5fb6-46bd-a4a2-920234fa3008"),
                I18NCode = "core"
            },
            new()
            {
                Id = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0"),
                I18NCode = "legs"
            },
            new()
            {
                Id = Guid.Parse("d96149dd-5a5e-4cca-a94a-842693ae62cc"),
                I18NCode = "neck"
            }
        };

        builder.HasData(muscleGroups);
    }
}