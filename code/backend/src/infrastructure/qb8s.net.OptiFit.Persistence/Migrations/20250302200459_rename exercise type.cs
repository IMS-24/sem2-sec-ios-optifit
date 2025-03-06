using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class renameexercisetype : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_exercise_types_exercise_type_id",
                table: "exercise");

            migrationBuilder.RenameTable(
                name: "exercise_type",
                newName: "exercise_group");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_group_i18n_code",
                table: "exercise_group",
                column: "i18n_code",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_exercise_types_exercise_type_id",
                table: "exercise",
                column: "exercise_type_id",
                principalTable: "exercise_group",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_exercise_types_exercise_type_id",
                table: "exercise");

            migrationBuilder.DropTable(
                name: "exercise_group");

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
                name: "ix_exercise_type_i18n_code",
                table: "exercise_type",
                column: "i18n_code",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_exercise_types_exercise_type_id",
                table: "exercise",
                column: "exercise_type_id",
                principalTable: "exercise_type",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
