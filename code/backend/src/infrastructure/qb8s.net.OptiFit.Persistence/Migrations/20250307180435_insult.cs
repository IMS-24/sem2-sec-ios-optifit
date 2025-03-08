using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class insult : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "total_insults",
                table: "user",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "insult",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    message = table.Column<string>(type: "character varying(2000)", maxLength: 2000, nullable: false),
                    level = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_insult", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "user_insult",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    time_stamp_utc = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    insult_id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user_insult", x => x.id);
                    table.ForeignKey(
                        name: "fk_user_insult_insult_insult_id",
                        column: x => x.insult_id,
                        principalTable: "insult",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_user_insult_users_user_id",
                        column: x => x.user_id,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.UpdateData(
                table: "user",
                keyColumn: "id",
                keyValue: new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5"),
                column: "total_insults",
                value: 0);

            migrationBuilder.CreateIndex(
                name: "ix_user_insult_insult_id",
                table: "user_insult",
                column: "insult_id");

            migrationBuilder.CreateIndex(
                name: "ix_user_insult_user_id",
                table: "user_insult",
                column: "user_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "user_insult");

            migrationBuilder.DropTable(
                name: "insult");

            migrationBuilder.DropColumn(
                name: "total_insults",
                table: "user");
        }
    }
}
