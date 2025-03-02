using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class UserEntityTypeConfiguration : BaseEntityTypeConfiguration<User>
{
    protected override void Configure(EntityTypeBuilder<User> builder)
    {
        builder
            .ToTable("user");

        builder
            .Property(x => x.UserName)
            .IsRequired()
            .HasMaxLength(30);

        builder
            .Property(u => u.Email)
            .IsRequired()
            .HasMaxLength(100);

        builder
            .HasIndex(x => x.UserName)
            .IsUnique();

        builder
            .Property(x => x.FirstName)
            .IsRequired()
            .HasMaxLength(30);

        builder
            .Property(x => x.LastName)
            .IsRequired()
            .HasMaxLength(30);

        builder
            .Property(x => x.OId)
            .IsRequired();

        builder
            .Property(x => x.UserRoleId)
            //Make sure to change the default value if you change the user roles
            .HasDefaultValue(Guid.Parse("a42ccbdf-e689-4b12-9333-88c19fe8462d"));

        builder.Property(x => x.RegisteredUtc)
            .HasDefaultValueSql("now()")
            .IsRequired();

        builder.Property(x => x.UpdatedUtc)
            .HasDefaultValueSql("now()")
            .IsRequired();

        #region RelationShips

        builder
            .HasMany(u => u.Workouts)
            .WithOne(w => w.User)
            .HasForeignKey(w => w.UserId);

        #endregion

        builder.HasData(new User
        {
            Id = new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5"),
            RegisteredUtc = new DateTime(2023, 01, 01),
            UpdatedUtc = new DateTime(2023, 01, 01),
            DateOfBirthUtc = new DateTime(1992, 11, 17),
            Email = "t1000@mstoegerer.net",
            FirstName = "Arnold",
            LastName = "Schwarzenegger",
            UserName = "TheTerminator"
        });
    }
}