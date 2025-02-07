using ToDo.Core;
using ToDo.Application.Interfaces;
using ToDo.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using ToDo.Api.Utilities;

namespace ToDo.Api.Controllers
{
    public class CountriesController : BaseCrudController<CountryDto, CountryUpsertDto, CountrySearchObject, ICountriesService>
    {
        public CountriesController(ICountriesService service, ILogger<CountriesController> logger) : base(service, logger)
        {
        }

        [Authorization(Role.Administrator)]
        public override Task<IActionResult> Post([FromBody] CountryUpsertDto upsertDto, CancellationToken cancellationToken = default)
        {
            return base.Post(upsertDto, cancellationToken);
        }

        [AllowAnonymous]
        public override Task<IActionResult> GetPaged([FromQuery] CountrySearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }
    }
}
