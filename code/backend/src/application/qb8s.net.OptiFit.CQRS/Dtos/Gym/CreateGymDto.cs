namespace qb8s.net.OptiFit.CQRS.Dtos.Gym;

public class CreateGymDto
{
    public Guid Id { get; set; }
    public required string Name { get; set; }
    public string? Address { get; set; } = null!;
    public string? City { get; set; } = null!;
    public int? ZipCode { get; set; }
}