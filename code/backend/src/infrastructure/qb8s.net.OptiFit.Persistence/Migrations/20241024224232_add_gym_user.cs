using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace qb8s.net.OptiFit.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class add_gym_user : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "created_by_id",
                table: "gym",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<DateTime>(
                name: "deleted_at_utc",
                table: "gym",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "ix_gym_created_by_id",
                table: "gym",
                column: "created_by_id");

            migrationBuilder.AddForeignKey(
                name: "fk_gym_users_created_by_id",
                table: "gym",
                column: "created_by_id",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_gym_users_created_by_id",
                table: "gym");

            migrationBuilder.DropIndex(
                name: "ix_gym_created_by_id",
                table: "gym");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "gym");

            migrationBuilder.DropColumn(
                name: "deleted_at_utc",
                table: "gym");
        }
    }
}
