using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class muscle_mappings : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_user_insult_users_user_id",
                table: "user_insult");

            migrationBuilder.InsertData(
                table: "muscle",
                columns: new[] { "id", "i18n_code" },
                values: new object[,]
                {
                    { new Guid("0d508e78-63fd-4791-9cf7-9ae27c592992"), "rectus_femoris" },
                    { new Guid("0d858c1e-ce72-49bf-98b4-90486c78f4cb"), "rectus_abdominus" },
                    { new Guid("1fc2ee21-48de-4d04-be6b-705137cc0aba"), "sternocleidomastoid" },
                    { new Guid("26a51504-ec29-4c34-83d0-f30eb96f3618"), "vastus_medialis" },
                    { new Guid("30efc5a1-dbaf-431b-af06-c4cfbedc3dbe"), "tensor_fasciae_latae" },
                    { new Guid("45220fe9-fb78-467c-98b6-7945e896e9f3"), "flexor_carpi_ulnaris" },
                    { new Guid("45e5c3af-5e10-406e-b708-2abad02694b5"), "vastus_lateralis" },
                    { new Guid("4823559d-03bb-43c8-826e-5412ddd7d791"), "soleus" },
                    { new Guid("49580807-5aa7-4996-a0e9-0eb1a5919368"), "external_obliques" },
                    { new Guid("4ae8771a-0491-435f-82df-661a02c8cb69"), "gracilis" },
                    { new Guid("64b7017d-e26e-4f93-b92d-ba73b3941a36"), "extensor_carpi_radialis" },
                    { new Guid("699d985d-0a73-45b2-9f7c-df004db7cb38"), "adductor_magnus" },
                    { new Guid("6ceece66-b399-4d45-ba58-f83397d51947"), "lower_trapezius" },
                    { new Guid("752d6779-4e22-4b59-b690-a4d839e67277"), "thoracolumbar_fascia" },
                    { new Guid("7aafc169-e3ab-4fa9-afa4-c82640d7359d"), "adductor_longus_and_pectineus" },
                    { new Guid("85778671-d563-4b78-9f32-cb9598ad5ed3"), "brachialis" },
                    { new Guid("86d26416-93cf-444a-ac45-cf524887d321"), "semitendinosus" },
                    { new Guid("8906c044-9e04-464b-8cb9-51781ad15ab3"), "biceps_femoris" },
                    { new Guid("947fc6f1-2efb-4037-9d4c-52efdd0bd8ff"), "gluteus_maximus" },
                    { new Guid("a0b6e588-5ff2-4492-b6b8-cd3a08447613"), "sartorius" },
                    { new Guid("a1730500-474e-4de7-8e56-3a0d31fb49ad"), "brachioradialis" },
                    { new Guid("abc82724-f31f-40c1-a1f9-2bcf8ff5e7ab"), "gastrocnemius_lateral" },
                    { new Guid("ae989ab5-ad02-43e1-b6d6-34724be14d29"), "gluteus_medius" },
                    { new Guid("b4ba2b1a-cff9-4f90-bf16-1a9e3911a62d"), "rectus_abdominus_lower" },
                    { new Guid("c896e9b8-168c-406e-b065-5b2c668bca9a"), "gastrocnemius_medial" },
                    { new Guid("cb23da08-21ad-43e6-8143-ef5112f4e834"), "peroneus_longus" },
                    { new Guid("d0f1a9f4-36b5-4b08-96b7-78ca232313eb"), "flexor_carpi_radialis" },
                    { new Guid("e3446e83-664f-423a-9969-90a5a6ec6a03"), "omohyoid" }
                });

            migrationBuilder.InsertData(
                table: "muscle_group",
                columns: new[] { "id", "i18n_code" },
                values: new object[] { new Guid("d96149dd-5a5e-4cca-a94a-842693ae62cc"), "neck" });

            migrationBuilder.InsertData(
                table: "muscle_group_mapping",
                columns: new[] { "id", "muscle_group_id", "muscle_id" },
                values: new object[,]
                {
                    { new Guid("1f1e1c94-3cb9-4119-95ac-2ac59f70be4e"), new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), new Guid("8c31da5a-9148-4808-990e-8d4ddda5238e") },
                    { new Guid("229785ef-b58a-427d-b103-241d2022f7db"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("c1f824e4-215e-4aa5-b2eb-76980cb1fad2") },
                    { new Guid("2a3803e9-006d-4b2b-a93f-425b24dc7219"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("062c3b7f-e3e7-4106-9e70-91860a7b32d7") },
                    { new Guid("4cd0e90d-d738-44ca-a018-9675c2407af5"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("11fe1942-1954-4e4c-ac71-a65763b0d75b") },
                    { new Guid("6684811a-ce2b-4e26-8535-3f18c46042c9"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("434ffe54-9c02-4fd0-b30c-8c4b47521c5c") },
                    { new Guid("9aa919ba-71f6-4230-b7c3-c31d2dfda69b"), new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), new Guid("8f97c242-448a-459f-8722-d00e789f488c") },
                    { new Guid("9b358071-a6aa-4e29-a4cb-2bc219585294"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("825714d1-5df8-4d08-b28e-fa89c284ff73") },
                    { new Guid("05c17e09-8246-485d-b97e-34911eb9497d"), new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"), new Guid("752d6779-4e22-4b59-b690-a4d839e67277") },
                    { new Guid("0bb8cbe6-8986-4871-8b5d-0101a9cf3c93"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("7aafc169-e3ab-4fa9-afa4-c82640d7359d") },
                    { new Guid("1766a227-83e4-4ecc-998c-3b9305a1cd01"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("0d508e78-63fd-4791-9cf7-9ae27c592992") },
                    { new Guid("273d6feb-0f9d-4ec7-946e-eafc841cab9d"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("45220fe9-fb78-467c-98b6-7945e896e9f3") },
                    { new Guid("2b85e782-ece9-4b2c-b842-1f7b4f0a9cb8"), new Guid("d96149dd-5a5e-4cca-a94a-842693ae62cc"), new Guid("e3446e83-664f-423a-9969-90a5a6ec6a03") },
                    { new Guid("3b1cf97b-18d9-47d5-a58f-bd73e3108641"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("30efc5a1-dbaf-431b-af06-c4cfbedc3dbe") },
                    { new Guid("3bf585d5-06c2-4b5e-b738-fc7049c78aad"), new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"), new Guid("0d858c1e-ce72-49bf-98b4-90486c78f4cb") },
                    { new Guid("3db6755d-13f0-4ab0-b2bc-6e5dd4343bed"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("4ae8771a-0491-435f-82df-661a02c8cb69") },
                    { new Guid("5a345d20-15b9-441a-9305-48606fcedcf3"), new Guid("d96149dd-5a5e-4cca-a94a-842693ae62cc"), new Guid("1fc2ee21-48de-4d04-be6b-705137cc0aba") },
                    { new Guid("5b3a35a9-0316-4645-866d-a76e4c108464"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("4823559d-03bb-43c8-826e-5412ddd7d791") },
                    { new Guid("654346ee-4f8c-435f-94fd-525217b33204"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("a0b6e588-5ff2-4492-b6b8-cd3a08447613") },
                    { new Guid("65f18292-d074-4ce0-9f06-d00698ddac9b"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("c896e9b8-168c-406e-b065-5b2c668bca9a") },
                    { new Guid("66b2d341-bd71-4acf-a0af-b0edc0dc45ce"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("ae989ab5-ad02-43e1-b6d6-34724be14d29") },
                    { new Guid("6bc18f0c-d74c-490c-a442-a6f46b0b1519"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("64b7017d-e26e-4f93-b92d-ba73b3941a36") },
                    { new Guid("6d37bdb7-d372-4a91-b89a-dee09076ee56"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("947fc6f1-2efb-4037-9d4c-52efdd0bd8ff") },
                    { new Guid("72755086-3587-4c5d-9208-7bc7a62ad586"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("d0f1a9f4-36b5-4b08-96b7-78ca232313eb") },
                    { new Guid("8026649e-dad4-4d9d-92dd-bf1b1b355ce5"), new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"), new Guid("b4ba2b1a-cff9-4f90-bf16-1a9e3911a62d") },
                    { new Guid("869d7620-93ce-4618-89a8-e0980793508f"), new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"), new Guid("49580807-5aa7-4996-a0e9-0eb1a5919368") },
                    { new Guid("92511e42-782d-4c50-8797-7d21e13014d6"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("cb23da08-21ad-43e6-8143-ef5112f4e834") },
                    { new Guid("9bde4afe-0027-4c6e-a64f-96e7f6ad78b0"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("abc82724-f31f-40c1-a1f9-2bcf8ff5e7ab") },
                    { new Guid("a0613a49-1c57-4845-8ad0-975dac01272c"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("8906c044-9e04-464b-8cb9-51781ad15ab3") },
                    { new Guid("a91bdaf1-2547-4e93-8c64-60b967f80bf3"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("699d985d-0a73-45b2-9f7c-df004db7cb38") },
                    { new Guid("abb74748-eae2-4130-85d9-561a841371ad"), new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), new Guid("6ceece66-b399-4d45-ba58-f83397d51947") },
                    { new Guid("b8cdc988-55db-4979-b867-f953eaa7f1aa"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("86d26416-93cf-444a-ac45-cf524887d321") },
                    { new Guid("bcbc8be5-7083-4e74-ba03-c31a3d326de0"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("85778671-d563-4b78-9f32-cb9598ad5ed3") },
                    { new Guid("ceebd0cb-7b9d-43ec-9c17-28cc75a68fa6"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("a1730500-474e-4de7-8e56-3a0d31fb49ad") },
                    { new Guid("e06b5396-7edc-4b07-9e0b-1305aca44a34"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("26a51504-ec29-4c34-83d0-f30eb96f3618") },
                    { new Guid("e62e8d59-e2b8-4214-8b8c-237eaadd2860"), new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), new Guid("45e5c3af-5e10-406e-b708-2abad02694b5") }
                });

            migrationBuilder.AddForeignKey(
                name: "fk_user_insult_user_user_id",
                table: "user_insult",
                column: "user_id",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_user_insult_user_user_id",
                table: "user_insult");

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("05c17e09-8246-485d-b97e-34911eb9497d"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("0bb8cbe6-8986-4871-8b5d-0101a9cf3c93"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("1766a227-83e4-4ecc-998c-3b9305a1cd01"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("1f1e1c94-3cb9-4119-95ac-2ac59f70be4e"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("229785ef-b58a-427d-b103-241d2022f7db"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("273d6feb-0f9d-4ec7-946e-eafc841cab9d"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("2a3803e9-006d-4b2b-a93f-425b24dc7219"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("2b85e782-ece9-4b2c-b842-1f7b4f0a9cb8"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("3b1cf97b-18d9-47d5-a58f-bd73e3108641"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("3bf585d5-06c2-4b5e-b738-fc7049c78aad"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("3db6755d-13f0-4ab0-b2bc-6e5dd4343bed"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("4cd0e90d-d738-44ca-a018-9675c2407af5"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("5a345d20-15b9-441a-9305-48606fcedcf3"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("5b3a35a9-0316-4645-866d-a76e4c108464"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("654346ee-4f8c-435f-94fd-525217b33204"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("65f18292-d074-4ce0-9f06-d00698ddac9b"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("6684811a-ce2b-4e26-8535-3f18c46042c9"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("66b2d341-bd71-4acf-a0af-b0edc0dc45ce"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("6bc18f0c-d74c-490c-a442-a6f46b0b1519"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("6d37bdb7-d372-4a91-b89a-dee09076ee56"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("72755086-3587-4c5d-9208-7bc7a62ad586"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("8026649e-dad4-4d9d-92dd-bf1b1b355ce5"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("869d7620-93ce-4618-89a8-e0980793508f"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("92511e42-782d-4c50-8797-7d21e13014d6"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("9aa919ba-71f6-4230-b7c3-c31d2dfda69b"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("9b358071-a6aa-4e29-a4cb-2bc219585294"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("9bde4afe-0027-4c6e-a64f-96e7f6ad78b0"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("a0613a49-1c57-4845-8ad0-975dac01272c"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("a91bdaf1-2547-4e93-8c64-60b967f80bf3"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("abb74748-eae2-4130-85d9-561a841371ad"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("b8cdc988-55db-4979-b867-f953eaa7f1aa"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("bcbc8be5-7083-4e74-ba03-c31a3d326de0"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("ceebd0cb-7b9d-43ec-9c17-28cc75a68fa6"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("e06b5396-7edc-4b07-9e0b-1305aca44a34"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("e62e8d59-e2b8-4214-8b8c-237eaadd2860"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("0d508e78-63fd-4791-9cf7-9ae27c592992"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("0d858c1e-ce72-49bf-98b4-90486c78f4cb"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("1fc2ee21-48de-4d04-be6b-705137cc0aba"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("26a51504-ec29-4c34-83d0-f30eb96f3618"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("30efc5a1-dbaf-431b-af06-c4cfbedc3dbe"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("45220fe9-fb78-467c-98b6-7945e896e9f3"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("45e5c3af-5e10-406e-b708-2abad02694b5"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("4823559d-03bb-43c8-826e-5412ddd7d791"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("49580807-5aa7-4996-a0e9-0eb1a5919368"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("4ae8771a-0491-435f-82df-661a02c8cb69"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("64b7017d-e26e-4f93-b92d-ba73b3941a36"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("699d985d-0a73-45b2-9f7c-df004db7cb38"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("6ceece66-b399-4d45-ba58-f83397d51947"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("752d6779-4e22-4b59-b690-a4d839e67277"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("7aafc169-e3ab-4fa9-afa4-c82640d7359d"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("85778671-d563-4b78-9f32-cb9598ad5ed3"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("86d26416-93cf-444a-ac45-cf524887d321"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("8906c044-9e04-464b-8cb9-51781ad15ab3"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("947fc6f1-2efb-4037-9d4c-52efdd0bd8ff"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("a0b6e588-5ff2-4492-b6b8-cd3a08447613"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("a1730500-474e-4de7-8e56-3a0d31fb49ad"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("abc82724-f31f-40c1-a1f9-2bcf8ff5e7ab"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("ae989ab5-ad02-43e1-b6d6-34724be14d29"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("b4ba2b1a-cff9-4f90-bf16-1a9e3911a62d"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("c896e9b8-168c-406e-b065-5b2c668bca9a"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("cb23da08-21ad-43e6-8143-ef5112f4e834"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("d0f1a9f4-36b5-4b08-96b7-78ca232313eb"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("e3446e83-664f-423a-9969-90a5a6ec6a03"));

            migrationBuilder.DeleteData(
                table: "muscle_group",
                keyColumn: "id",
                keyValue: new Guid("d96149dd-5a5e-4cca-a94a-842693ae62cc"));

            migrationBuilder.AddForeignKey(
                name: "fk_user_insult_users_user_id",
                table: "user_insult",
                column: "user_id",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
