using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class MuscleEntityTypeConfiguration : BaseEntityTypeConfiguration<Muscle>
{
    protected override void Configure(EntityTypeBuilder<Muscle> builder)
    {
        builder
            .ToTable("muscle");

        builder
            .Property(m => m.I18NCode)
            .IsRequired()
            .HasMaxLength(50);

        builder
            .HasIndex(m => m.I18NCode)
            .IsUnique();

        builder
            .HasMany(m => m.MuscleGroupMappings)
            .WithOne(mgm => mgm.Muscle)
            .HasForeignKey(mgm => mgm.MuscleId);

        builder
            .HasMany(m => m.ExerciseMuscleMappings)
            .WithOne(emm => emm.Muscle)
            .HasForeignKey(emm => emm.MuscleId);

        var muscles = new List<Muscle>
        {
            new()
            {
                Id = Guid.Parse("dbf4ee29-c4d0-4d5e-8846-78c2632d4ea3"),
                I18NCode = "pectoralis_major"
            },
            new()
            {
                Id = Guid.Parse("4805c4a7-9d81-4eee-951a-ba82aaeb0efb"),
                I18NCode = "pectoralis_minor"
            },
            new()
            {
                Id = Guid.Parse("eb36b354-ef08-4bbf-b41b-244788bd62e1"),
                I18NCode = "serratus_anterior"
            },
            new()
            {
                Id = Guid.Parse("8f97c242-448a-459f-8722-d00e789f488c"),
                I18NCode = "latissimus_dorsi"
            },
            new()
            {
                Id = Guid.Parse("a8b00e77-002c-4db3-a22f-892934250f1b"),
                I18NCode = "trapezius"
            },
            new()
            {
                Id = Guid.Parse("8c31da5a-9148-4808-990e-8d4ddda5238e"),
                I18NCode = "rhomboids"
            },
            new()
            {
                Id = Guid.Parse("434ffe54-9c02-4fd0-b30c-8c4b47521c5c"),
                I18NCode = "teres_major"
            },
            new()
            {
                Id = Guid.Parse("321ebc13-5400-44f6-9334-14bac89618ad"),
                I18NCode = "erector_spinae"
            },
            new()
            {
                Id = Guid.Parse("062c3b7f-e3e7-4106-9e70-91860a7b32d7"),
                I18NCode = "infraspinatus"
            },
            new()
            {
                Id = Guid.Parse("c1f824e4-215e-4aa5-b2eb-76980cb1fad2"),
                I18NCode = "teres_minor"
            },
            new()
            {
                Id = Guid.Parse("825714d1-5df8-4d08-b28e-fa89c284ff73"),
                I18NCode = "deltoid_anterior"
            },
            new()
            {
                Id = Guid.Parse("11fe1942-1954-4e4c-ac71-a65763b0d75b"),
                I18NCode = "deltoid_lateral"
            },
            new()
            {
                Id = Guid.Parse("23893afe-3d7b-4202-90e9-30d5f8ce1875"),
                I18NCode = "deltoid_posterior"
            },
            new()
            {
                Id = Guid.Parse("fa48dea0-0493-4923-841a-51a8b6649b30"),
                I18NCode = "biceps_brachii"
            },
            new()
            {
                Id = Guid.Parse("80c63a73-a8f0-4d38-a038-898dbca6876e"),
                I18NCode = "triceps_brachii"
            }
        };

        builder.HasData(muscles);
    }
}