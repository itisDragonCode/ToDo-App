using ToDo.Core;

namespace ToDo.Application
{
    public class AnswerProfile : BaseProfile
    {
        public AnswerProfile()
        {
            CreateMap<AnswerDto, Answer>().ReverseMap();

            CreateMap<AnswerUpsertDto, Answer>();
        }
    }
}
