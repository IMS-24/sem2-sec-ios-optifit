using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class full_db2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_workout_gyms_gym_id",
                table: "workout");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_users_user_id",
                table: "workout");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_log_workout_workout_id",
                table: "workout_log");

            migrationBuilder.AlterColumn<string>(
                name: "notes",
                table: "workout",
                type: "character varying(200)",
                maxLength: 200,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(500)",
                oldMaxLength: 500);

            migrationBuilder.AddColumn<string>(
                name: "description",
                table: "workout",
                type: "character varying(500)",
                maxLength: 500,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "zip_code",
                table: "gym",
                type: "character varying(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(10)",
                oldMaxLength: 10);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_gym_gym_id",
                table: "workout",
                column: "gym_id",
                principalTable: "gym",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_user_user_id",
                table: "workout",
                column: "user_id",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_log_workouts_workout_id",
                table: "workout_log",
                column: "workout_id",
                principalTable: "workout",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_workout_gym_gym_id",
                table: "workout");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_user_user_id",
                table: "workout");

            migrationBuilder.DropForeignKey(
                name: "fk_workout_log_workouts_workout_id",
                table: "workout_log");

            migrationBuilder.DropColumn(
                name: "description",
                table: "workout");

            migrationBuilder.AlterColumn<string>(
                name: "notes",
                table: "workout",
                type: "character varying(500)",
                maxLength: 500,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(200)",
                oldMaxLength: 200,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "zip_code",
                table: "gym",
                type: "character varying(10)",
                maxLength: 10,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(10)",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_gyms_gym_id",
                table: "workout",
                column: "gym_id",
                principalTable: "gym",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_users_user_id",
                table: "workout",
                column: "user_id",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_workout_log_workout_workout_id",
                table: "workout_log",
                column: "workout_id",
                principalTable: "workout",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
