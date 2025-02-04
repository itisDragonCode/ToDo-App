using ToDo.Core;

namespace ToDo.Application
{
    public class CountryProfile : BaseProfile
    {
        public CountryProfile()
        {
            CreateMap<CountryDto, Country>().ReverseMap();

            CreateMap<CountryUpsertDto, Country>();
        }
    }
}
