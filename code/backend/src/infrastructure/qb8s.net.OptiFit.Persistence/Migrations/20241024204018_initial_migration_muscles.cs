using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class initial_migration_muscles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "muscle_group_mapping");

            migrationBuilder.DropTable(
                name: "muscle_group");

            migrationBuilder.DropTable(
                name: "muscle");
        }
    }
}
