using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class full_db : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_muscle_group_mappings_exercises_exercise_id",
                table: "exercise_muscle_group_mappings");

            migrationBuilder.DropForeignKey(
                name: "fk_exercise_muscle_group_mappings_muscle_groups_muscle_group_id",
                table: "exercise_muscle_group_mappings");

            migrationBuilder.DropForeignKey(
                name: "fk_gym_users_created_by_id",
                table: "gym");

            migrationBuilder.DropIndex(
                name: "ix_gym_created_by_id",
                table: "gym");

            migrationBuilder.DropPrimaryKey(
                name: "pk_exercise_muscle_group_mappings",
                table: "exercise_muscle_group_mappings");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "gym");

            migrationBuilder.RenameTable(
                name: "exercise_muscle_group_mappings",
                newName: "exercise_muscle_group_mapping");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_muscle_group_mappings_muscle_group_id",
                table: "exercise_muscle_group_mapping",
                newName: "ix_exercise_muscle_group_mapping_muscle_group_id");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_muscle_group_mappings_exercise_id",
                table: "exercise_muscle_group_mapping",
                newName: "ix_exercise_muscle_group_mapping_exercise_id");

            migrationBuilder.AlterColumn<Guid>(
                name: "user_role_id",
                table: "user",
                type: "uuid",
                nullable: true,
                defaultValue: new Guid("a42ccbdf-e689-4b12-9333-88c19fe8462d"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true,
                oldDefaultValue: new Guid("034ba653-e026-4f13-a050-3d0d9b408be2"));

            migrationBuilder.AddColumn<string>(
                name: "email",
                table: "user",
                type: "character varying(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

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

            migrationBuilder.AddColumn<string>(
                name: "description",
                table: "exercise",
                type: "character varying(500)",
                maxLength: 500,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<Guid>(
                name: "id",
                table: "exercise_muscle_group_mapping",
                type: "uuid",
                nullable: false,
                defaultValueSql: "uuid_generate_v4()",
                oldClrType: typeof(Guid),
                oldType: "uuid");

            migrationBuilder.AddPrimaryKey(
                name: "pk_exercise_muscle_group_mapping",
                table: "exercise_muscle_group_mapping",
                column: "id");

            migrationBuilder.CreateTable(
                name: "gym_exercise_mapping",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    gym_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    is_available = table.Column<bool>(type: "boolean", nullable: false),
                    notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_gym_exercise_mapping", x => x.id);
                    table.ForeignKey(
                        name: "fk_gym_exercise_mapping_exercises_exercise_id",
                        column: x => x.exercise_id,
                        principalTable: "exercise",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_gym_exercise_mapping_gyms_gym_id",
                        column: x => x.gym_id,
                        principalTable: "gym",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    start_at_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    end_at_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    gym_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_gyms_gym_id",
                        column: x => x.gym_id,
                        principalTable: "gym",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_workout_users_user_id",
                        column: x => x.user_id,
                        principalTable: "user",
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
                    start_at = table.Column<DateOnly>(type: "date", nullable: false),
                    end_at = table.Column<DateOnly>(type: "date", nullable: false),
                    notes = table.Column<string>(type: "text", nullable: false),
                    is_active = table.Column<bool>(type: "boolean", nullable: false),
                    name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false)
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
                name: "workout_log",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    order = table.Column<int>(type: "integer", nullable: false),
                    workout_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    reps = table.Column<int>(type: "integer", nullable: false),
                    weight = table.Column<decimal>(type: "numeric", nullable: false),
                    notes = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false)
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
                        name: "fk_workout_log_workout_workout_id",
                        column: x => x.workout_id,
                        principalTable: "workout",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "workout_plan_exercise_mapping",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    workout_plan_id = table.Column<Guid>(type: "uuid", nullable: false),
                    exercise_id = table.Column<Guid>(type: "uuid", nullable: false),
                    rest_time = table.Column<int>(type: "integer", nullable: false),
                    notes = table.Column<string>(type: "text", nullable: false),
                    day = table.Column<int>(type: "integer", nullable: false),
                    exercise_id1 = table.Column<Guid>(type: "uuid", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout_plan_exercise_mapping", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_plan_exercise_mapping_exercise_exercise_id1",
                        column: x => x.exercise_id1,
                        principalTable: "exercise",
                        principalColumn: "id");
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

            migrationBuilder.UpdateData(
                table: "user",
                keyColumn: "id",
                keyValue: new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5"),
                columns: new[] { "email", "user_role_id" },
                values: new object[] { "t1000@mstoegerer.net", new Guid("a42ccbdf-e689-4b12-9333-88c19fe8462d") });

            migrationBuilder.CreateIndex(
                name: "ix_exercise_i18n_code",
                table: "exercise",
                column: "i18n_code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_gym_exercise_mapping_exercise_id",
                table: "gym_exercise_mapping",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_gym_exercise_mapping_gym_id",
                table: "gym_exercise_mapping",
                column: "gym_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_gym_id",
                table: "workout",
                column: "gym_id");

            migrationBuilder.CreateIndex(
                name: "ix_workout_user_id",
                table: "workout",
                column: "user_id");

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
                name: "ix_workout_plan_exercise_mapping_exercise_id1",
                table: "workout_plan_exercise_mapping",
                column: "exercise_id1");

            migrationBuilder.CreateIndex(
                name: "ix_workout_plan_exercise_mapping_workout_plan_id",
                table: "workout_plan_exercise_mapping",
                column: "workout_plan_id");

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_muscle_group_mapping_exercise_exercise_id",
                table: "exercise_muscle_group_mapping",
                column: "exercise_id",
                principalTable: "exercise",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_muscle_group_mapping_muscle_groups_muscle_group_id",
                table: "exercise_muscle_group_mapping",
                column: "muscle_group_id",
                principalTable: "muscle_group",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_exercise_muscle_group_mapping_exercise_exercise_id",
                table: "exercise_muscle_group_mapping");

            migrationBuilder.DropForeignKey(
                name: "fk_exercise_muscle_group_mapping_muscle_groups_muscle_group_id",
                table: "exercise_muscle_group_mapping");

            migrationBuilder.DropTable(
                name: "gym_exercise_mapping");

            migrationBuilder.DropTable(
                name: "workout_log");

            migrationBuilder.DropTable(
                name: "workout_plan_exercise_mapping_sets");

            migrationBuilder.DropTable(
                name: "workout");

            migrationBuilder.DropTable(
                name: "workout_plan_exercise_mapping");

            migrationBuilder.DropTable(
                name: "workout_plan");

            migrationBuilder.DropIndex(
                name: "ix_exercise_i18n_code",
                table: "exercise");

            migrationBuilder.DropPrimaryKey(
                name: "pk_exercise_muscle_group_mapping",
                table: "exercise_muscle_group_mapping");

            migrationBuilder.DropColumn(
                name: "email",
                table: "user");

            migrationBuilder.DropColumn(
                name: "description",
                table: "exercise");

            migrationBuilder.RenameTable(
                name: "exercise_muscle_group_mapping",
                newName: "exercise_muscle_group_mappings");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_muscle_group_mapping_muscle_group_id",
                table: "exercise_muscle_group_mappings",
                newName: "ix_exercise_muscle_group_mappings_muscle_group_id");

            migrationBuilder.RenameIndex(
                name: "ix_exercise_muscle_group_mapping_exercise_id",
                table: "exercise_muscle_group_mappings",
                newName: "ix_exercise_muscle_group_mappings_exercise_id");

            migrationBuilder.AlterColumn<Guid>(
                name: "user_role_id",
                table: "user",
                type: "uuid",
                nullable: true,
                defaultValue: new Guid("034ba653-e026-4f13-a050-3d0d9b408be2"),
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldNullable: true,
                oldDefaultValue: new Guid("a42ccbdf-e689-4b12-9333-88c19fe8462d"));

            migrationBuilder.AlterColumn<string>(
                name: "zip_code",
                table: "gym",
                type: "character varying(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(10)",
                oldMaxLength: 10);

            migrationBuilder.AddColumn<Guid>(
                name: "created_by_id",
                table: "gym",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AlterColumn<Guid>(
                name: "id",
                table: "exercise_muscle_group_mappings",
                type: "uuid",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uuid",
                oldDefaultValueSql: "uuid_generate_v4()");

            migrationBuilder.AddPrimaryKey(
                name: "pk_exercise_muscle_group_mappings",
                table: "exercise_muscle_group_mappings",
                column: "id");

            migrationBuilder.UpdateData(
                table: "user",
                keyColumn: "id",
                keyValue: new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5"),
                column: "user_role_id",
                value: new Guid("034ba653-e026-4f13-a050-3d0d9b408be2"));

            migrationBuilder.CreateIndex(
                name: "ix_gym_created_by_id",
                table: "gym",
                column: "created_by_id");

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_muscle_group_mappings_exercises_exercise_id",
                table: "exercise_muscle_group_mappings",
                column: "exercise_id",
                principalTable: "exercise",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_exercise_muscle_group_mappings_muscle_groups_muscle_group_id",
                table: "exercise_muscle_group_mappings",
                column: "muscle_group_id",
                principalTable: "muscle_group",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_gym_users_created_by_id",
                table: "gym",
                column: "created_by_id",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
