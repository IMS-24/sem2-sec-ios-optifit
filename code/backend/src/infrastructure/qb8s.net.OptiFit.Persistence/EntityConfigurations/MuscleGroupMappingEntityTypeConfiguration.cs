using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class MuscleGroupMappingEntityTypeConfiguration : BaseEntityTypeConfiguration<MuscleGroupMapping>
{
    protected override void Configure(EntityTypeBuilder<MuscleGroupMapping> builder)
    {
        builder
            .ToTable("muscle_group_mapping");

        builder
            .Property(m => m.MuscleGroupId)
            .IsRequired();

        builder
            .Property(m => m.MuscleId)
            .IsRequired();

        builder
            .HasOne(mgm => mgm.Muscle)
            .WithMany(m => m.MuscleGroupMappings)
            .HasForeignKey(mgm => mgm.MuscleId);

        builder
            .HasOne(mgm => mgm.MuscleGroup)
            .WithMany(mg => mg.MuscleGroupMappings)
            .HasForeignKey(mgm => mgm.MuscleGroupId);

        var muscleGroupMappings = new List<MuscleGroupMapping>
        {
            new()
            {
                Id = Guid.Parse("921265d2-ad78-425e-b63e-c8b44a1c05a5"),
                MuscleId = Guid.Parse("dbf4ee29-c4d0-4d5e-8846-78c2632d4ea3"),
                MuscleGroupId = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11") // chest
            },
            new()
            {
                Id = Guid.Parse("966b7f6b-9881-4f0e-b217-4b80013839e7"),
                MuscleId = Guid.Parse("4805c4a7-9d81-4eee-951a-ba82aaeb0efb"),
                MuscleGroupId = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11") // chest
            },
            new()
            {
                Id = Guid.Parse("86cb778d-7bd2-47ea-b9da-374e175a0e19"),
                MuscleId = Guid.Parse("eb36b354-ef08-4bbf-b41b-244788bd62e1"),
                MuscleGroupId = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11") // chest
            },
            new()
            {
                Id = Guid.Parse("87723876-7436-4415-8a10-af0308683b03"),
                MuscleId = Guid.Parse("eb36b354-ef08-4bbf-b41b-244788bd62e1"),
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("adb3a641-1fce-4cee-9992-8411ef57a3a3"),
                MuscleId = Guid.Parse("a8b00e77-002c-4db3-a22f-892934250f1b"),
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("7bc92a90-408e-4033-9b84-0b2b5c07dca2"),
                MuscleId = Guid.Parse("a8b00e77-002c-4db3-a22f-892934250f1b"),
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("901360e1-0852-4740-aaba-4b51a2dadd8f"),
                MuscleId = Guid.Parse("321ebc13-5400-44f6-9334-14bac89618ad"),
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("07fc11a4-5198-4edd-9323-b09519544087"),
                MuscleId = Guid.Parse("321ebc13-5400-44f6-9334-14bac89618ad"),
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("56c19c96-b597-405d-bd58-cdce4b91007e"),
                MuscleId = Guid.Parse("23893afe-3d7b-4202-90e9-30d5f8ce1875"),
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("3006945e-9c4d-477b-8740-b033cac055b2"),
                MuscleId = Guid.Parse("fa48dea0-0493-4923-841a-51a8b6649b30"),
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("9493ba2b-0248-4ac7-af1b-6956b2fb02ce"),
                MuscleId = Guid.Parse("80c63a73-a8f0-4d38-a038-898dbca6876e"),
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            }
        };


        builder.HasData(muscleGroupMappings);
    }
}