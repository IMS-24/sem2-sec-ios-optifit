using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class removeworkout_plan : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "workout_log");

            migrationBuilder.DropTable(
                name: "workout_plan_exercise_mapping_sets");

            migrationBuilder.DropTable(
                name: "workout_plan_exercise_mapping");

            migrationBuilder.DropTable(
                name: "workout_plan");

            migrationBuilder.CreateTable(
                name: "workout_exercise",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    order = table.Column<int>(type: "integer", nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_exercise", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_exercise_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_workout_exercise_workouts_workout_id",
                        column: x => x.workout_id,
                        principalTable: "workout",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout_set",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    order = table.Column<int>(type: "integer", nullable: false),
                    reps = table.Column<int>(type: "integer", nullable: false),
                    weight = table.Column<decimal>(type: "numeric", nullable: false),
                    workout_exercise_id = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_set", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_set_workout_exercise_workout_exercise_id",
                        column: x => x.workout_exercise_id,
                        principalTable: "workout_exercise",
                        principalColumn: "id");
                });

            migrationBuilder.CreateIndex(
                name: "ix_workout_exercise_exercise_id",
                table: "workout_exercise",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_exercise_workout_id",
                table: "workout_exercise",
                column: "workout_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_set_workout_exercise_id",
                table: "workout_set",
                column: "workout_exercise_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "workout_set");

            migrationBuilder.DropTable(
                name: "workout_exercise");

            migrationBuilder.CreateTable(
                name: "workout_log",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: false),
                    notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true),
                    order = table.Column<int>(type: "integer", nullable: false),
                    reps = table.Column<int>(type: "integer", nullable: false),
                    weight = table.Column<decimal>(type: "numeric", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_log", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_log_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_workout_log_workouts_workout_id",
                        column: x => x.workout_id,
                        principalTable: "workout",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout_plan",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    description = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    end_at = table.Column<DateOnly>(type: "date", nullable: false),
                    is_active = table.Column<bool>(type: "boolean", nullable: false),
                    name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    notes = table.Column<string>(type: "text", nullable: false),
                    start_at = table.Column<DateOnly>(type: "date", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_plan", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_plan_users_user_id",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout_plan_exercise_mapping",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    workout_plan_id = table.Column<Guid>(type: "uuid", nullable: false),
                    day = table.Column<int>(type: "integer", nullable: false),
                    notes = table.Column<string>(type: "text", nullable: false),
                    rest_time = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_plan_exercise_mapping", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_plan_exercise_mapping_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_workout_plan_exercise_mapping_workout_plan_workout_plan_id",
                        column: x => x.workout_plan_id,
                        principalTable: "workout_plan",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout_plan_exercise_mapping_sets",
                columns: table => new
                {
                    workout_plan_exercise_mapping_id = table.Column<Guid>(type: "uuid", nullable: false),
                    id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    order = table.Column<int>(type: "integer", nullable: false),
                    reps = table.Column<int>(type: "integer", nullable: false),
                    weight = table.Column<decimal>(type: "numeric", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_plan_exercise_mapping_sets", x => new { x.workout_plan_exercise_mapping_id, x.id });
                    table.ForeignKey(
                        name: "fk_workout_plan_exercise_mapping_sets_workout_plan_exercise_ma",
                        column: x => x.workout_plan_exercise_mapping_id,
                        principalTable: "workout_plan_exercise_mapping",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "ix_workout_log_exercise_id",
                table: "workout_log",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_log_workout_id",
                table: "workout_log",
                column: "workout_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_plan_user_id",
                table: "workout_plan",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_plan_exercise_mapping_exercise_id",
                table: "workout_plan_exercise_mapping",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_plan_exercise_mapping_workout_plan_id",
                table: "workout_plan_exercise_mapping",
                column: "workout_plan_id");
        }
    }
}
