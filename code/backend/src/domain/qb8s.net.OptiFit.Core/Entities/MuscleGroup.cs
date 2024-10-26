using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class MuscleGroup : BaseI18NEntity
{
    public ICollection<MuscleGroupMapping> MuscleGroupMappings { get; set; } = new HashSet<MuscleGroupMapping>();

    public ICollection<ExerciseMuscleGroupMapping> ExerciseMuscleGroupMappings { get; set; } =
        new HashSet<ExerciseMuscleGroupMapping>();
}