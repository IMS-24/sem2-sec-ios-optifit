using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class seed_gym_exercise_types : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_user_user_role_user_role_id",
                table: "user");

            migrationBuilder.CreateTable(
                name: "exercise_type",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    i18n_code = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise_type", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "gym",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    address = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    city = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: true),
                    zip_code = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: true),
                    name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_gym", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "exercise",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    exercise_type_id = table.Column<Guid>(type: "uuid", nullable: false),
                    i18n_code = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise", x => x.id);
                    table.ForeignKey(
                        name: "fk_exercise_exercise_types_exercise_type_id",
                        column: x => x.exercise_type_id,
                        principalTable: "exercise_type",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "exercise_muscle_group_mappings",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    muscle_group_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise_muscle_group_mappings", x => x.id);
                    table.ForeignKey(
                        name: "fk_exercise_muscle_group_mappings_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_exercise_muscle_group_mappings_muscle_groups_muscle_group_id",
                        column: x => x.muscle_group_id,
                        principalTable: "muscle_group",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "exercise_muscle_mapping",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    muscle_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise_muscle_mapping", x => x.id);
                    table.ForeignKey(
                        name: "fk_exercise_muscle_mapping_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_exercise_muscle_mapping_muscles_muscle_id",
                        column: x => x.muscle_id,
                        principalTable: "muscle",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "exercise_type",
                columns: new[] { "id", "i18n_code" },
                values: new object[,]
                {
                    { new Guid("353cc6f0-c36d-493b-950c-0166f6159d25"), "legs" },
                    { new Guid("92d3c7a3-bab6-4d49-afce-70ed62b7814e"), "push" },
                    { new Guid("b4508634-2e74-49b1-88bd-01041aed3e2b"), "pull" }
                });

            migrationBuilder.CreateIndex(
                name: "ix_exercise_exercise_type_id",
                table: "exercise",
                column: "exercise_type_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_group_mappings_exercise_id",
                table: "exercise_muscle_group_mappings",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_group_mappings_muscle_group_id",
                table: "exercise_muscle_group_mappings",
                column: "muscle_group_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_mapping_exercise_id",
                table: "exercise_muscle_mapping",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_mapping_muscle_id",
                table: "exercise_muscle_mapping",
                column: "muscle_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_type_i18n_code",
                table: "exercise_type",
                column: "i18n_code",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "fk_user_user_roles_user_role_id",
                table: "user",
                column: "user_role_id",
                principalTable: "user_role",
                principalColumn: "id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_user_user_roles_user_role_id",
                table: "user");

            migrationBuilder.DropTable(
                name: "exercise_muscle_group_mappings");

            migrationBuilder.DropTable(
                name: "exercise_muscle_mapping");

            migrationBuilder.DropTable(
                name: "gym");

            migrationBuilder.DropTable(
                name: "exercise");

            migrationBuilder.DropTable(
                name: "exercise_type");

            migrationBuilder.AddForeignKey(
                name: "fk_user_user_role_user_role_id",
                table: "user",
                column: "user_role_id",
                principalTable: "user_role",
                principalColumn: "id");
        }
    }
}
