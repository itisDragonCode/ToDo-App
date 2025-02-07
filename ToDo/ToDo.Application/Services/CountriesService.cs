using AutoMapper;
using FluentValidation;

using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure;
using ToDo.Infrastructure.Interfaces;

namespace ToDo.Application
{
    public class CountriesService : BaseService<Country, CountryDto, CountryUpsertDto, CountrySearchObject, ICountriesRepository>, ICountriesService
    {
        public CountriesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<CountryUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
