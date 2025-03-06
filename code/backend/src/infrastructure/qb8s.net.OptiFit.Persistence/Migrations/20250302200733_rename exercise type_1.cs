using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class renameexercisetype_1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_exercise_types_exercise_type_id",
                table: "exercise");

            migrationBuilder.RenameColumn(
                name: "exercise_type_id",
                table: "exercise",
                newName: "exercise_category_id");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_exercise_type_id",
                table: "exercise",
                newName: "ix_exercise_exercise_category_id");

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_exercise_types_exercise_category_id",
                table: "exercise",
                column: "exercise_category_id",
                principalTable: "exercise_group",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_exercise_types_exercise_category_id",
                table: "exercise");

            migrationBuilder.RenameColumn(
                name: "exercise_category_id",
                table: "exercise",
                newName: "exercise_type_id");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_exercise_category_id",
                table: "exercise",
                newName: "ix_exercise_exercise_type_id");

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_exercise_types_exercise_type_id",
                table: "exercise",
                column: "exercise_type_id",
                principalTable: "exercise_group",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
