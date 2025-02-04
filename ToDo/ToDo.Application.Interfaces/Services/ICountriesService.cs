using ToDo.Core;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application.Interfaces
{
    public interface ICountriesService : IBaseService<int, CountryDto, CountryUpsertDto, CountrySearchObject>
    {

    }
}
