using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class full_db1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_workout_plan_exercise_mapping_exercise_exercise_id1",
                table: "workout_plan_exercise_mapping");

            migrationBuilder.DropIndex(
                name: "ix_workout_plan_exercise_mapping_exercise_id1",
                table: "workout_plan_exercise_mapping");

            migrationBuilder.DropColumn(
                name: "exercise_id1",
                table: "workout_plan_exercise_mapping");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "exercise_id1",
                table: "workout_plan_exercise_mapping",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "ix_workout_plan_exercise_mapping_exercise_id1",
                table: "workout_plan_exercise_mapping",
                column: "exercise_id1");

            migrationBuilder.AddForeignKey(
                name: "fk_workout_plan_exercise_mapping_exercise_exercise_id1",
                table: "workout_plan_exercise_mapping",
                column: "exercise_id1",
                principalTable: "exercise",
                principalColumn: "id");
        }
    }
}
