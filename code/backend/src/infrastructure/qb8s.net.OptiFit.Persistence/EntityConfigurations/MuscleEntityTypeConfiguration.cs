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
            // Chest / Upper Body
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
            },

            // ----------------------------
            // Arms (Additional)
            // ----------------------------
            new()
            {
                Id = Guid.Parse("85778671-d563-4b78-9f32-cb9598ad5ed3"),
                I18NCode = "brachialis"
            },
            new()
            {
                Id = Guid.Parse("a1730500-474e-4de7-8e56-3a0d31fb49ad"),
                I18NCode = "brachioradialis"
            },
            new()
            {
                Id = Guid.Parse("64b7017d-e26e-4f93-b92d-ba73b3941a36"),
                I18NCode = "extensor_carpi_radialis"
            },
            new()
            {
                Id = Guid.Parse("d0f1a9f4-36b5-4b08-96b7-78ca232313eb"),
                I18NCode = "flexor_carpi_radialis"
            },
            new()
            {
                Id = Guid.Parse("45220fe9-fb78-467c-98b6-7945e896e9f3"),
                I18NCode = "flexor_carpi_ulnaris"
            },

            // ----------------------------
            // Legs
            // ----------------------------
            new()
            {
                Id = Guid.Parse("699d985d-0a73-45b2-9f7c-df004db7cb38"),
                I18NCode = "adductor_magnus"
            },
            new()
            {
                Id = Guid.Parse("7aafc169-e3ab-4fa9-afa4-c82640d7359d"),
                I18NCode = "adductor_longus_and_pectineus"
            },
            new()
            {
                Id = Guid.Parse("4ae8771a-0491-435f-82df-661a02c8cb69"),
                I18NCode = "gracilis"
            },
            new()
            {
                Id = Guid.Parse("8906c044-9e04-464b-8cb9-51781ad15ab3"),
                I18NCode = "biceps_femoris"
            },
            new()
            {
                Id = Guid.Parse("86d26416-93cf-444a-ac45-cf524887d321"),
                I18NCode = "semitendinosus"
            },
            new()
            {
                Id = Guid.Parse("abc82724-f31f-40c1-a1f9-2bcf8ff5e7ab"),
                I18NCode = "gastrocnemius_lateral"
            },
            new()
            {
                Id = Guid.Parse("c896e9b8-168c-406e-b065-5b2c668bca9a"),
                I18NCode = "gastrocnemius_medial"
            },
            new()
            {
                Id = Guid.Parse("4823559d-03bb-43c8-826e-5412ddd7d791"),
                I18NCode = "soleus"
            },
            new()
            {
                Id = Guid.Parse("cb23da08-21ad-43e6-8143-ef5112f4e834"),
                I18NCode = "peroneus_longus"
            },
            new()
            {
                Id = Guid.Parse("0d508e78-63fd-4791-9cf7-9ae27c592992"),
                I18NCode = "rectus_femoris"
            },
            new()
            {
                Id = Guid.Parse("45e5c3af-5e10-406e-b708-2abad02694b5"),
                I18NCode = "vastus_lateralis"
            },
            new()
            {
                Id = Guid.Parse("26a51504-ec29-4c34-83d0-f30eb96f3618"),
                I18NCode = "vastus_medialis"
            },
            new()
            {
                Id = Guid.Parse("947fc6f1-2efb-4037-9d4c-52efdd0bd8ff"),
                I18NCode = "gluteus_maximus"
            },
            new()
            {
                Id = Guid.Parse("ae989ab5-ad02-43e1-b6d6-34724be14d29"),
                I18NCode = "gluteus_medius"
            },
            new()
            {
                Id = Guid.Parse("a0b6e588-5ff2-4492-b6b8-cd3a08447613"),
                I18NCode = "sartorius"
            },
            new()
            {
                Id = Guid.Parse("30efc5a1-dbaf-431b-af06-c4cfbedc3dbe"),
                I18NCode = "tensor_fasciae_latae"
            },

            // ----------------------------
            // Core
            // ----------------------------
            new()
            {
                Id = Guid.Parse("49580807-5aa7-4996-a0e9-0eb1a5919368"),
                I18NCode = "external_obliques"
            },
            new()
            {
                Id = Guid.Parse("0d858c1e-ce72-49bf-98b4-90486c78f4cb"),
                I18NCode = "rectus_abdominus"
            },
            new()
            {
                Id = Guid.Parse("b4ba2b1a-cff9-4f90-bf16-1a9e3911a62d"),
                I18NCode = "rectus_abdominus_lower"
            },
            new()
            {
                Id = Guid.Parse("752d6779-4e22-4b59-b690-a4d839e67277"),
                I18NCode = "thoracolumbar_fascia"
            },

            // ----------------------------
            // Back (Additional)
            // ----------------------------
            new()
            {
                Id = Guid.Parse("6ceece66-b399-4d45-ba58-f83397d51947"),
                I18NCode = "lower_trapezius"
            },

            // ----------------------------
            // Neck
            // ----------------------------
            new()
            {
                Id = Guid.Parse("1fc2ee21-48de-4d04-be6b-705137cc0aba"),
                I18NCode = "sternocleidomastoid"
            },
            new()
            {
                Id = Guid.Parse("e3446e83-664f-423a-9969-90a5a6ec6a03"),
                I18NCode = "omohyoid"
            }
        };
        builder.HasData(muscles);
    }
}