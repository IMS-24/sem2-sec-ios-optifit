using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class removemuscle_group : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "exercise_muscle_group_mapping");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "exercise_muscle_group_mapping",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    muscle_group_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_exercise_muscle_group_mapping", x => x.id);
                    table.ForeignKey(
                        name: "fk_exercise_muscle_group_mapping_exercise_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_exercise_muscle_group_mapping_muscle_groups_muscle_group_id",
                        column: x => x.muscle_group_id,
                        principalTable: "muscle_group",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_group_mapping_exercise_id",
                table: "exercise_muscle_group_mapping",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_group_mapping_muscle_group_id",
                table: "exercise_muscle_group_mapping",
                column: "muscle_group_id");
        }
    }
}
