using ToDo.Core;

namespace ToDo.Application
{
    public class QuestionProfile : BaseProfile
    {
        public QuestionProfile()
        {
            CreateMap<QuestionDto, Question>().ReverseMap();

            CreateMap<QuestionUpsertDto, Question>();
        }
    }
}
