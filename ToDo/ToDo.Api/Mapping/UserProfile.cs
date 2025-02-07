using ToDo.Api;
using ToDo.Core;

namespace ToDo.Application
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<AccessSignUpModel, UserUpsertDto>();
        }
    }
}
