using ToDo.Core;

namespace ToDo.Application
{
    public class UserQuizProfile : BaseProfile
    {
        public UserQuizProfile()
        {
            CreateMap<UserQuizDto, UserQuiz>().ReverseMap();

            CreateMap<UserQuizUpsertDto, UserQuiz>();
        }
    }
}
