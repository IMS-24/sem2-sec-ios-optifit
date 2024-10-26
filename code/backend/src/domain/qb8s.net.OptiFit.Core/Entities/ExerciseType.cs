using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class ExerciseType : BaseI18NEntity
{
    public ICollection<Exercise> Exercises { get; set; } = new HashSet<Exercise>();
}