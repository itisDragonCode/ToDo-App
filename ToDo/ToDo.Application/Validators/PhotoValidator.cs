using FluentValidation;

using ToDo.Core;

namespace ToDo.Application
{
    public class PhotoValidator : AbstractValidator<PhotoUpsertDto>
    {
        public PhotoValidator()
        {
            RuleFor(c => c.Data).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
          
        }
    }
}
