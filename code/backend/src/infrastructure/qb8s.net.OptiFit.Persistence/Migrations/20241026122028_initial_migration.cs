using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class initial_migration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("Npgsql:PostgresExtension:uuid-ossp", ",,");

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
                    city = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    zip_code = table.Column<int>(type: "integer", nullable: true),
                    deleted_at_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    name = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_gym", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "muscle",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    i18n_code = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_muscle", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "muscle_group",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    i18n_code = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_muscle_group", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "user_role",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user_role", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "exercise",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    description = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
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
                name: "muscle_group_mapping",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    muscle_group_id = table.Column<Guid>(type: "uuid", nullable: false),
                    muscle_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_muscle_group_mapping", x => x.id);
                    table.ForeignKey(
                        name: "fk_muscle_group_mapping_muscle_group_muscle_group_id",
                        column: x => x.muscle_group_id,
                        principalTable: "muscle_group",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_muscle_group_mapping_muscle_muscle_id",
                        column: x => x.muscle_id,
                        principalTable: "muscle",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "user",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    user_name = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    email = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    first_name = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    last_name = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    o_id = table.Column<Guid>(type: "uuid", nullable: false),
                    user_role_id = table.Column<Guid>(type: "uuid", nullable: true, defaultValue: new Guid("a42ccbdf-e689-4b12-9333-88c19fe8462d")),
                    date_of_birth_utc = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    last_login_utc = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    registered_utc = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false, defaultValueSql: "now()"),
                    updated_utc = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false, defaultValueSql: "now()"),
                    initial_setup_done = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user", x => x.id);
                    table.ForeignKey(
                        name: "fk_user_user_roles_user_role_id",
                        column: x => x.user_role_id,
                        principalTable: "user_role",
                        principalColumn: "id");
                });

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
                    description = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: false),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    start_at_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    end_at_utc = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    notes = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: true),
                    gym_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_workout", x => x.id);
                    table.ForeignKey(
                        name: "fk_workout_gym_gym_id",
                        column: x => x.gym_id,
                        principalTable: "gym",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_workout_user_user_id",
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
                        name: "fk_workout_log_workouts_workout_id",
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
                    day = table.Column<int>(type: "integer", nullable: false)
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

            migrationBuilder.InsertData(
                table: "exercise_type",
                columns: new[] { "id", "i18n_code" },
                values: new object[,]
                {
                    { new Guid("353cc6f0-c36d-493b-950c-0166f6159d25"), "legs" },
                    { new Guid("92d3c7a3-bab6-4d49-afce-70ed62b7814e"), "push" },
                    { new Guid("b4508634-2e74-49b1-88bd-01041aed3e2b"), "pull" }
                });

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
                    { new Guid("4279276a-ec31-4dc7-b4b4-b490d67acbd0"), "legs" },
                    { new Guid("af4d7669-3a4a-480b-b8aa-17e39ad4d8c8"), "shoulders" },
                    { new Guid("ca487800-5fb6-46bd-a4a2-920234fa3008"), "core" },
                    { new Guid("d26ed0c4-2941-49e9-9c09-efce5663ab92"), "back" },
                    { new Guid("e05de925-1e66-4547-8950-1d26e5de9e11"), "chest" }
                });

            migrationBuilder.InsertData(
                table: "user_role",
                columns: new[] { "id", "name" },
                values: new object[,]
                {
                    { new Guid("034ba653-e026-4f13-a050-3d0d9b408be2"), "User" },
                    { new Guid("47c81565-a603-42a7-bbdc-a3d41ccfb022"), "Guest" },
                    { new Guid("8e281066-f933-4f7e-95c8-c4acab20a7e9"), "Admin" },
                    { new Guid("a42ccbdf-e689-4b12-9333-88c19fe8462d"), "Root-Admin" },
                    { new Guid("da18fe0f-5590-471d-9288-9481bc6396d7"), "Moderator" }
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

            migrationBuilder.InsertData(
                table: "user",
                columns: new[] { "id", "date_of_birth_utc", "email", "first_name", "initial_setup_done", "last_login_utc", "last_name", "o_id", "registered_utc", "updated_utc", "user_name" },
                values: new object[] { new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5"), new DateTimeOffset(new DateTime(1992, 11, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 1, 0, 0, 0)), "t1000@mstoegerer.net", "Arnold", false, null, "Schwarzenegger", new Guid("00000000-0000-0000-0000-000000000000"), new DateTimeOffset(new DateTime(2023, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 1, 0, 0, 0)), new DateTimeOffset(new DateTime(2023, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 1, 0, 0, 0)), "TheTerminator" });

            migrationBuilder.CreateIndex(
                name: "ix_exercise_exercise_type_id",
                table: "exercise",
                column: "exercise_type_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_i18n_code",
                table: "exercise",
                column: "i18n_code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_group_mapping_exercise_id",
                table: "exercise_muscle_group_mapping",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_exercise_muscle_group_mapping_muscle_group_id",
                table: "exercise_muscle_group_mapping",
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

            migrationBuilder.CreateIndex(
                name: "ix_gym_exercise_mapping_exercise_id",
                table: "gym_exercise_mapping",
                column: "exercise_id");

            migrationBuilder.CreateIndex(
                name: "ix_gym_exercise_mapping_gym_id",
                table: "gym_exercise_mapping",
                column: "gym_id");

            migrationBuilder.CreateIndex(
                name: "ix_muscle_i18n_code",
                table: "muscle",
                column: "i18n_code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_muscle_group_i18n_code",
                table: "muscle_group",
                column: "i18n_code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_muscle_group_mapping_muscle_group_id",
                table: "muscle_group_mapping",
                column: "muscle_group_id");

            migrationBuilder.CreateIndex(
                name: "ix_muscle_group_mapping_muscle_id",
                table: "muscle_group_mapping",
                column: "muscle_id");

            migrationBuilder.CreateIndex(
                name: "ix_user_user_name",
                table: "user",
                column: "user_name",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_user_user_role_id",
                table: "user",
                column: "user_role_id");

            migrationBuilder.CreateIndex(
                name: "ix_user_role_name",
                table: "user_role",
                column: "name",
                unique: true);

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
                name: "ix_workout_plan_exercise_mapping_workout_plan_id",
                table: "workout_plan_exercise_mapping",
                column: "workout_plan_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "exercise_muscle_group_mapping");

            migrationBuilder.DropTable(
                name: "exercise_muscle_mapping");

            migrationBuilder.DropTable(
                name: "gym_exercise_mapping");

            migrationBuilder.DropTable(
                name: "muscle_group_mapping");

            migrationBuilder.DropTable(
                name: "workout_log");

            migrationBuilder.DropTable(
                name: "workout_plan_exercise_mapping_sets");

            migrationBuilder.DropTable(
                name: "muscle_group");

            migrationBuilder.DropTable(
                name: "muscle");

            migrationBuilder.DropTable(
                name: "workout");

            migrationBuilder.DropTable(
                name: "workout_plan_exercise_mapping");

            migrationBuilder.DropTable(
                name: "gym");

            migrationBuilder.DropTable(
                name: "exercise");

            migrationBuilder.DropTable(
                name: "workout_plan");

            migrationBuilder.DropTable(
                name: "exercise_type");

            migrationBuilder.DropTable(
                name: "user");

            migrationBuilder.DropTable(
                name: "user_role");
        }
    }
}
