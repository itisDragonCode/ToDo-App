﻿using Microsoft.AspNetCore.Mvc;

namespace ToDo.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public abstract class BaseController : ControllerBase
    {
        protected readonly ILogger<BaseController> Logger;

        protected BaseController(ILogger<BaseController> logger)
        {
            Logger = logger;
        }
    }
}
