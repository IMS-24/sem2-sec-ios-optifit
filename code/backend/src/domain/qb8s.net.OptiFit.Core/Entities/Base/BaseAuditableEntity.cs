namespace qb8s.net.OptiFit.Core.Entities.Base;

public abstract class BaseAuditableEntity : BaseEntity
{
    public Guid CreatedById { get; set; }

    public Guid UpdatedById { get; set; }

    public Guid? DeletedById { get; set; }

    public DateTimeOffset CreatedUtc { get; set; }

    public DateTimeOffset UpdatedUtc { get; set; }

    public DateTimeOffset? DeletedUtc { get; set; }
}