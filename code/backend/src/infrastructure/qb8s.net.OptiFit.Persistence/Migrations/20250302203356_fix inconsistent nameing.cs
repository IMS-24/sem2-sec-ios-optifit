using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class fixinconsistentnameing : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_exercise_types_exercise_category_id",
                table: "exercise");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_set_workout_exercise_workout_exercise_id",
                table: "workout_set");

            migrationBuilder.DropPrimaryKey(
                name: "pk_exercise_type",
                table: "exercise_group");

            migrationBuilder.RenameTable(
                name: "exercise_group",
                newName: "exercise_category");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_group_i18n_code",
                table: "exercise_category",
                newName: "ix_exercise_category_i18n_code");

            migrationBuilder.AlterColumn<Guid>(
                name: "workout_exercise_id",
                table: "workout_set",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "pk_exercise_category",
                table: "exercise_category",
                column: "id");

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_exercise_category_exercise_category_id",
                table: "exercise",
                column: "exercise_category_id",
                principalTable: "exercise_category",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_set_workout_exercise_workout_exercise_id",
                table: "workout_set",
                column: "workout_exercise_id",
                principalTable: "workout_exercise",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_exercise_category_exercise_category_id",
                table: "exercise");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_set_workout_exercise_workout_exercise_id",
                table: "workout_set");

            migrationBuilder.DropPrimaryKey(
                name: "pk_exercise_category",
                table: "exercise_category");

            migrationBuilder.RenameTable(
                name: "exercise_category",
                newName: "exercise_group");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_category_i18n_code",
                table: "exercise_group",
                newName: "ix_exercise_group_i18n_code");

            migrationBuilder.AlterColumn<Guid>(
                name: "workout_exercise_id",
                table: "workout_set",
                type: "uuid",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AddPrimaryKey(
                name: "pk_exercise_group",
                table: "exercise_group",
                column: "id");

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_exercise_types_exercise_category_id",
                table: "exercise",
                column: "exercise_category_id",
                principalTable: "exercise_group",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_set_workout_exercise_workout_exercise_id",
                table: "workout_set",
                column: "workout_exercise_id",
                principalTable: "workout_exercise",
                principalColumn: "id");
        }
    }
}
