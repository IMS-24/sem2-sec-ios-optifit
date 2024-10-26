using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class UserRoleEntityTypeConfiguration : BaseEntityTypeConfiguration<UserRole>
{
    protected override void Configure(EntityTypeBuilder<UserRole> builder)
    {
        builder
            .ToTable("user_role");

        builder
            .HasIndex(x => x.Name)
            .IsUnique();

        builder.HasMany(ur => ur.Users)
            .WithOne(u => u.UserRole)
            .HasForeignKey(u => u.UserRoleId);

        builder
            .HasData(new List<UserRole>
            {
                new()
                {
                    Id = Guid.Parse("a42ccbdf-e689-4b12-9333-88c19fe8462d"),
                    Name = "Root-Admin"
                },
                new()
                {
                    Id = Guid.Parse("8e281066-f933-4f7e-95c8-c4acab20a7e9"),
                    Name = "Admin"
                },
                new()
                {
                    Id = Guid.Parse("da18fe0f-5590-471d-9288-9481bc6396d7"),
                    Name = "Moderator"
                },
                new()
                {
                    Id = Guid.Parse("034ba653-e026-4f13-a050-3d0d9b408be2"),
                    Name = "User"
                },
                new()
                {
                    Id = Guid.Parse("47c81565-a603-42a7-bbdc-a3d41ccfb022"),
                    Name = "Guest"
                }
            });
    }
}