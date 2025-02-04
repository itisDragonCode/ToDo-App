
using ToDo.Core;

namespace ToDo.Infrastructure.Interfaces
{
    public interface ICountriesRepository : IBaseRepository<Country, int, CountrySearchObject>
    {
    }
}
