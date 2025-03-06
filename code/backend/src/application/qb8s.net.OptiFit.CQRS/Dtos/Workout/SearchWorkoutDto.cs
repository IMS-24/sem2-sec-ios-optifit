using qb8s.net.OptiFit.CQRS.Dtos.Base.Search;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class SearchWorkoutDto : SearchBaseDto
{
    public DateTimeOffset? From { get; set; }
    public DateTimeOffset? To { get; set; }
}