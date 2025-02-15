using qb8s.net.OptiFit.Core.Entities;
using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class ExerciseTypeDto
{
    public Guid Id { get; set; }
    public string I18NCode { get; set; }
}

public class ExerciseTypeDtoProfile : BaseProfile
{
    public ExerciseTypeDtoProfile()
    {
        CreateMap<ExerciseType, ExerciseTypeDto>()
            .ForMember(dest => dest.I18NCode, opt => opt.MapFrom(src => src.I18NCode));
    }
}