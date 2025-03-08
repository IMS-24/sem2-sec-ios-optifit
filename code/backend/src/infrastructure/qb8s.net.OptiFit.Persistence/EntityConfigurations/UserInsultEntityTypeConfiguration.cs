using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.Persistence.EntityConfigurations;

public class UserInsultEntityTypeConfiguration : BaseEntityTypeConfiguration<UserInsult>
{
    protected override void Configure(EntityTypeBuilder<UserInsult> builder)
    {
        builder.ToTable("user_insult");

        builder
            .Property(e => e.InsultId)
            .IsRequired();

        builder
            .Property(e => e.UserId)
            .IsRequired();

        builder
            .HasOne(ui => ui.Insult)
            .WithMany(i => i.UserInsultsCollection)
            .HasForeignKey(ui => ui.InsultId);

        builder
            .HasOne(ui => ui.User)
            .WithMany(u => u.UserInsults)
            .HasForeignKey(ui => ui.UserId);
    }
}