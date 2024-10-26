using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class ExerciseDto : BaseI18NDto
{
    public string? Description { get; set; }
}

public class ExerciseDtoProfile : Profile
{
    public ExerciseDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, ExerciseDto>()
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description));
    }
}