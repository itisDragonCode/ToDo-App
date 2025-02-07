using FluentValidation;

using ToDo.Core;

namespace ToDo.Application
{
    public class QuizValidator : AbstractValidator<QuizUpsertDto>
    {
        public QuizValidator()
        {
            RuleFor(u => u.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
