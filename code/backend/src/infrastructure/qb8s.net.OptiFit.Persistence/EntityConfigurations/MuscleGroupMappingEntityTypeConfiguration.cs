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
                MuscleId = Guid.Parse("dbf4ee29-c4d0-4d5e-8846-78c2632d4ea3"), // pectoralis_major
                MuscleGroupId = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11") // chest
            },
            new()
            {
                Id = Guid.Parse("966b7f6b-9881-4f0e-b217-4b80013839e7"),
                MuscleId = Guid.Parse("4805c4a7-9d81-4eee-951a-ba82aaeb0efb"), // pectoralis_minor
                MuscleGroupId = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11") // chest
            },
            new()
            {
                Id = Guid.Parse("86cb778d-7bd2-47ea-b9da-374e175a0e19"),
                MuscleId = Guid.Parse("eb36b354-ef08-4bbf-b41b-244788bd62e1"), // serratus_anterior
                MuscleGroupId = Guid.Parse("e05de925-1e66-4547-8950-1d26e5de9e11") // chest
            },
            new()
            {
                Id = Guid.Parse("87723876-7436-4415-8a10-af0308683b03"),
                MuscleId = Guid.Parse("eb36b354-ef08-4bbf-b41b-244788bd62e1"), // serratus_anterior
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("adb3a641-1fce-4cee-9992-8411ef57a3a3"),
                MuscleId = Guid.Parse("a8b00e77-002c-4db3-a22f-892934250f1b"), // trapezius
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("7bc92a90-408e-4033-9b84-0b2b5c07dca2"),
                MuscleId = Guid.Parse("a8b00e77-002c-4db3-a22f-892934250f1b"), // trapezius
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("901360e1-0852-4740-aaba-4b51a2dadd8f"),
                MuscleId = Guid.Parse("321ebc13-5400-44f6-9334-14bac89618ad"), // erector_spinae
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("07fc11a4-5198-4edd-9323-b09519544087"),
                MuscleId = Guid.Parse("321ebc13-5400-44f6-9334-14bac89618ad"), // erector_spinae
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("56c19c96-b597-405d-bd58-cdce4b91007e"),
                MuscleId = Guid.Parse("23893afe-3d7b-4202-90e9-30d5f8ce1875"), // deltoid_posterior
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("3006945e-9c4d-477b-8740-b033cac055b2"),
                MuscleId = Guid.Parse("fa48dea0-0493-4923-841a-51a8b6649b30"), // biceps_brachii
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("9493ba2b-0248-4ac7-af1b-6956b2fb02ce"),
                MuscleId = Guid.Parse("80c63a73-a8f0-4d38-a038-898dbca6876e"), // triceps_brachii
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("9aa919ba-71f6-4230-b7c3-c31d2dfda69b"),
                MuscleId = Guid.Parse("8f97c242-448a-459f-8722-d00e789f488c"), // latissimus_dorsi
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("1f1e1c94-3cb9-4119-95ac-2ac59f70be4e"),
                MuscleId = Guid.Parse("8c31da5a-9148-4808-990e-8d4ddda5238e"), // rhomboids
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            new()
            {
                Id = Guid.Parse("6684811a-ce2b-4e26-8535-3f18c46042c9"),
                MuscleId = Guid.Parse("434ffe54-9c02-4fd0-b30c-8c4b47521c5c"), // teres_major
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("2a3803e9-006d-4b2b-a93f-425b24dc7219"),
                MuscleId = Guid.Parse("062c3b7f-e3e7-4106-9e70-91860a7b32d7"), // infraspinatus
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("229785ef-b58a-427d-b103-241d2022f7db"),
                MuscleId = Guid.Parse("c1f824e4-215e-4aa5-b2eb-76980cb1fad2"), // teres_minor
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("9b358071-a6aa-4e29-a4cb-2bc219585294"),
                MuscleId = Guid.Parse("825714d1-5df8-4d08-b28e-fa89c284ff73"), // deltoid_anterior
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            new()
            {
                Id = Guid.Parse("4cd0e90d-d738-44ca-a018-9675c2407af5"),
                MuscleId = Guid.Parse("11fe1942-1954-4e4c-ac71-a65763b0d75b"), // deltoid_lateral
                MuscleGroupId = Guid.Parse("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8") // shoulders
            },
            // Arms (Additional)
            new()
            {
                Id = Guid.Parse("bcbc8be5-7083-4e74-ba03-c31a3d326de0"),
                MuscleId = Guid.Parse("85778671-d563-4b78-9f32-cb9598ad5ed3"), // brachialis
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("ceebd0cb-7b9d-43ec-9c17-28cc75a68fa6"),
                MuscleId = Guid.Parse("a1730500-474e-4de7-8e56-3a0d31fb49ad"), // brachioradialis
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("6bc18f0c-d74c-490c-a442-a6f46b0b1519"),
                MuscleId = Guid.Parse("64b7017d-e26e-4f93-b92d-ba73b3941a36"), // extensor_carpi_radialis
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("72755086-3587-4c5d-9208-7bc7a62ad586"),
                MuscleId = Guid.Parse("d0f1a9f4-36b5-4b08-96b7-78ca232313eb"), // flexor_carpi_radialis
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            new()
            {
                Id = Guid.Parse("273d6feb-0f9d-4ec7-946e-eafc841cab9d"),
                MuscleId = Guid.Parse("45220fe9-fb78-467c-98b6-7945e896e9f3"), // flexor_carpi_ulnaris
                MuscleGroupId = Guid.Parse("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2") // arms
            },
            // Legs
            new()
            {
                Id = Guid.Parse("a91bdaf1-2547-4e93-8c64-60b967f80bf3"),
                MuscleId = Guid.Parse("699d985d-0a73-45b2-9f7c-df004db7cb38"), // adductor_magnus
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("0bb8cbe6-8986-4871-8b5d-0101a9cf3c93"),
                MuscleId = Guid.Parse("7aafc169-e3ab-4fa9-afa4-c82640d7359d"), // adductor_longus_and_pectineus
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("3db6755d-13f0-4ab0-b2bc-6e5dd4343bed"),
                MuscleId = Guid.Parse("4ae8771a-0491-435f-82df-661a02c8cb69"), // gracilis
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("a0613a49-1c57-4845-8ad0-975dac01272c"),
                MuscleId = Guid.Parse("8906c044-9e04-464b-8cb9-51781ad15ab3"), // biceps_femoris
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("b8cdc988-55db-4979-b867-f953eaa7f1aa"),
                MuscleId = Guid.Parse("86d26416-93cf-444a-ac45-cf524887d321"), // semitendinosus
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("9bde4afe-0027-4c6e-a64f-96e7f6ad78b0"),
                MuscleId = Guid.Parse("abc82724-f31f-40c1-a1f9-2bcf8ff5e7ab"), // gastrocnemius_lateral
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("65f18292-d074-4ce0-9f06-d00698ddac9b"),
                MuscleId = Guid.Parse("c896e9b8-168c-406e-b065-5b2c668bca9a"), // gastrocnemius_medial
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("5b3a35a9-0316-4645-866d-a76e4c108464"),
                MuscleId = Guid.Parse("4823559d-03bb-43c8-826e-5412ddd7d791"), // soleus
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("92511e42-782d-4c50-8797-7d21e13014d6"),
                MuscleId = Guid.Parse("cb23da08-21ad-43e6-8143-ef5112f4e834"), // peroneus_longus
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("1766a227-83e4-4ecc-998c-3b9305a1cd01"),
                MuscleId = Guid.Parse("0d508e78-63fd-4791-9cf7-9ae27c592992"), // rectus_femoris
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("e62e8d59-e2b8-4214-8b8c-237eaadd2860"),
                MuscleId = Guid.Parse("45e5c3af-5e10-406e-b708-2abad02694b5"), // vastus_lateralis
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("e06b5396-7edc-4b07-9e0b-1305aca44a34"),
                MuscleId = Guid.Parse("26a51504-ec29-4c34-83d0-f30eb96f3618"), // vastus_medialis
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("6d37bdb7-d372-4a91-b89a-dee09076ee56"),
                MuscleId = Guid.Parse("947fc6f1-2efb-4037-9d4c-52efdd0bd8ff"), // gluteus_maximus
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("66b2d341-bd71-4acf-a0af-b0edc0dc45ce"),
                MuscleId = Guid.Parse("ae989ab5-ad02-43e1-b6d6-34724be14d29"), // gluteus_medius
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("654346ee-4f8c-435f-94fd-525217b33204"),
                MuscleId = Guid.Parse("a0b6e588-5ff2-4492-b6b8-cd3a08447613"), // sartorius
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            new()
            {
                Id = Guid.Parse("3b1cf97b-18d9-47d5-a58f-bd73e3108641"),
                MuscleId = Guid.Parse("30efc5a1-dbaf-431b-af06-c4cfbedc3dbe"), // tensor_fasciae_latae
                MuscleGroupId = Guid.Parse("4279276a-ec31-4dc7-b4b4-b490d67acbd0") // legs
            },
            // Core
            new()
            {
                Id = Guid.Parse("869d7620-93ce-4618-89a8-e0980793508f"),
                MuscleId = Guid.Parse("49580807-5aa7-4996-a0e9-0eb1a5919368"), // external_obliques
                MuscleGroupId = Guid.Parse("ca487800-5fb6-46bd-a4a2-920234fa3008") // core
            },
            new()
            {
                Id = Guid.Parse("3bf585d5-06c2-4b5e-b738-fc7049c78aad"),
                MuscleId = Guid.Parse("0d858c1e-ce72-49bf-98b4-90486c78f4cb"), // rectus_abdominus
                MuscleGroupId = Guid.Parse("ca487800-5fb6-46bd-a4a2-920234fa3008") // core
            },
            new()
            {
                Id = Guid.Parse("8026649e-dad4-4d9d-92dd-bf1b1b355ce5"),
                MuscleId = Guid.Parse("b4ba2b1a-cff9-4f90-bf16-1a9e3911a62d"), // rectus_abdominus_lower
                MuscleGroupId = Guid.Parse("ca487800-5fb6-46bd-a4a2-920234fa3008") // core
            },
            new()
            {
                Id = Guid.Parse("05c17e09-8246-485d-b97e-34911eb9497d"),
                MuscleId = Guid.Parse("752d6779-4e22-4b59-b690-a4d839e67277"), // thoracolumbar_fascia
                MuscleGroupId = Guid.Parse("ca487800-5fb6-46bd-a4a2-920234fa3008") // core
            },
            // Back
            new()
            {
                Id = Guid.Parse("abb74748-eae2-4130-85d9-561a841371ad"),
                MuscleId = Guid.Parse("6ceece66-b399-4d45-ba58-f83397d51947"), // lower_trapezius
                MuscleGroupId = Guid.Parse("d26ed0c4-2941-49e9-9c09-efce5663ab92") // back
            },
            // Neck
            new()
            {
                Id = Guid.Parse("5a345d20-15b9-441a-9305-48606fcedcf3"),
                MuscleId = Guid.Parse("1fc2ee21-48de-4d04-be6b-705137cc0aba"), // sternocleidomastoid
                MuscleGroupId = Guid.Parse("d96149dd-5a5e-4cca-a94a-842693ae62cc") // neck
            },
            new()
            {
                Id = Guid.Parse("2b85e782-ece9-4b2c-b842-1f7b4f0a9cb8"),
                MuscleId = Guid.Parse("e3446e83-664f-423a-9969-90a5a6ec6a03"), // omohyoid
                MuscleGroupId = Guid.Parse("d96149dd-5a5e-4cca-a94a-842693ae62cc") // neck
            }
        };

        builder.HasData(muscleGroupMappings);
    }
}