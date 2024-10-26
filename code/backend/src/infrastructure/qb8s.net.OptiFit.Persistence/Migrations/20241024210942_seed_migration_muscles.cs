using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class seed_migration_muscles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "muscle",
                columns: new[] { "id", "i18n_code" },
                values: new object[,]
                {
                    { new Guid("062c3b7f-e3e7-4106-9e70-91860a7b32d7"), "infraspinatus" },
                    { new Guid("11fe1942-1954-4e4c-ac71-a65763b0d75b"), "deltoid_lateral" },
                    { new Guid("23893afe-3d7b-4202-90e9-30d5f8ce1875"), "deltoid_posterior" },
                    { new Guid("321ebc13-5400-44f6-9334-14bac89618ad"), "erector_spinae" },
                    { new Guid("434ffe54-9c02-4fd0-b30c-8c4b47521c5c"), "teres_major" },
                    { new Guid("4805c4a7-9d81-4eee-951a-ba82aaeb0efb"), "pectoralis_minor" },
                    { new Guid("80c63a73-a8f0-4d38-a038-898dbca6876e"), "triceps_brachii" },
                    { new Guid("825714d1-5df8-4d08-b28e-fa89c284ff73"), "deltoid_anterior" },
                    { new Guid("8c31da5a-9148-4808-990e-8d4ddda5238e"), "rhomboids" },
                    { new Guid("8f97c242-448a-459f-8722-d00e789f488c"), "latissimus_dorsi" },
                    { new Guid("a8b00e77-002c-4db3-a22f-892934250f1b"), "trapezius" },
                    { new Guid("c1f824e4-215e-4aa5-b2eb-76980cb1fad2"), "teres_minor" },
                    { new Guid("dbf4ee29-c4d0-4d5e-8846-78c2632d4ea3"), "pectoralis_major" },
                    { new Guid("eb36b354-ef08-4bbf-b41b-244788bd62e1"), "serratus_anterior" },
                    { new Guid("fa48dea0-0493-4923-841a-51a8b6649b30"), "biceps_brachii" }
                });

            migrationBuilder.InsertData(
                table: "muscle_group",
                columns: new[] { "id", "i18n_code" },
                values: new object[,]
                {
                    { new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), "arms" },
                    { new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), "shoulders" },
                    { new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"), "core" },
                    { new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), "back" },
                    { new Guid("e05de925-1e66-4547-8950-1d26e5de9e11"), "chest" }
                });

            migrationBuilder.InsertData(
                table: "muscle_group_mapping",
                columns: new[] { "id", "muscle_group_id", "muscle_id" },
                values: new object[,]
                {
                    { new Guid("07fc11a4-5198-4edd-9323-b09519544087"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("321ebc13-5400-44f6-9334-14bac89618ad") },
                    { new Guid("3006945e-9c4d-477b-8740-b033cac055b2"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("fa48dea0-0493-4923-841a-51a8b6649b30") },
                    { new Guid("56c19c96-b597-405d-bd58-cdce4b91007e"), new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), new Guid("23893afe-3d7b-4202-90e9-30d5f8ce1875") },
                    { new Guid("7bc92a90-408e-4033-9b84-0b2b5c07dca2"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("a8b00e77-002c-4db3-a22f-892934250f1b") },
                    { new Guid("86cb778d-7bd2-47ea-b9da-374e175a0e19"), new Guid("e05de925-1e66-4547-8950-1d26e5de9e11"), new Guid("eb36b354-ef08-4bbf-b41b-244788bd62e1") },
                    { new Guid("87723876-7436-4415-8a10-af0308683b03"), new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), new Guid("eb36b354-ef08-4bbf-b41b-244788bd62e1") },
                    { new Guid("901360e1-0852-4740-aaba-4b51a2dadd8f"), new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), new Guid("321ebc13-5400-44f6-9334-14bac89618ad") },
                    { new Guid("921265d2-ad78-425e-b63e-c8b44a1c05a5"), new Guid("e05de925-1e66-4547-8950-1d26e5de9e11"), new Guid("dbf4ee29-c4d0-4d5e-8846-78c2632d4ea3") },
                    { new Guid("9493ba2b-0248-4ac7-af1b-6956b2fb02ce"), new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"), new Guid("80c63a73-a8f0-4d38-a038-898dbca6876e") },
                    { new Guid("966b7f6b-9881-4f0e-b217-4b80013839e7"), new Guid("e05de925-1e66-4547-8950-1d26e5de9e11"), new Guid("4805c4a7-9d81-4eee-951a-ba82aaeb0efb") },
                    { new Guid("adb3a641-1fce-4cee-9992-8411ef57a3a3"), new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), new Guid("a8b00e77-002c-4db3-a22f-892934250f1b") }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("062c3b7f-e3e7-4106-9e70-91860a7b32d7"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("11fe1942-1954-4e4c-ac71-a65763b0d75b"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("434ffe54-9c02-4fd0-b30c-8c4b47521c5c"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("825714d1-5df8-4d08-b28e-fa89c284ff73"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("8c31da5a-9148-4808-990e-8d4ddda5238e"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("8f97c242-448a-459f-8722-d00e789f488c"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("c1f824e4-215e-4aa5-b2eb-76980cb1fad2"));

            migrationBuilder.DeleteData(
                table: "muscle_group",
                keyColumn: "id",
                keyValue: new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("07fc11a4-5198-4edd-9323-b09519544087"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("3006945e-9c4d-477b-8740-b033cac055b2"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("56c19c96-b597-405d-bd58-cdce4b91007e"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("7bc92a90-408e-4033-9b84-0b2b5c07dca2"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("86cb778d-7bd2-47ea-b9da-374e175a0e19"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("87723876-7436-4415-8a10-af0308683b03"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("901360e1-0852-4740-aaba-4b51a2dadd8f"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("921265d2-ad78-425e-b63e-c8b44a1c05a5"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("9493ba2b-0248-4ac7-af1b-6956b2fb02ce"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("966b7f6b-9881-4f0e-b217-4b80013839e7"));

            migrationBuilder.DeleteData(
                table: "muscle_group_mapping",
                keyColumn: "id",
                keyValue: new Guid("adb3a641-1fce-4cee-9992-8411ef57a3a3"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("23893afe-3d7b-4202-90e9-30d5f8ce1875"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("321ebc13-5400-44f6-9334-14bac89618ad"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("4805c4a7-9d81-4eee-951a-ba82aaeb0efb"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("80c63a73-a8f0-4d38-a038-898dbca6876e"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("a8b00e77-002c-4db3-a22f-892934250f1b"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("dbf4ee29-c4d0-4d5e-8846-78c2632d4ea3"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("eb36b354-ef08-4bbf-b41b-244788bd62e1"));

            migrationBuilder.DeleteData(
                table: "muscle",
                keyColumn: "id",
                keyValue: new Guid("fa48dea0-0493-4923-841a-51a8b6649b30"));

            migrationBuilder.DeleteData(
                table: "muscle_group",
                keyColumn: "id",
                keyValue: new Guid("0a8ec2e6-f77d-4fdd-a216-e2bf7714c7f2"));

            migrationBuilder.DeleteData(
                table: "muscle_group",
                keyColumn: "id",
                keyValue: new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"));

            migrationBuilder.DeleteData(
                table: "muscle_group",
                keyColumn: "id",
                keyValue: new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"));

            migrationBuilder.DeleteData(
                table: "muscle_group",
                keyColumn: "id",
                keyValue: new Guid("e05de925-1e66-4547-8950-1d26e5de9e11"));
        }
    }
}
