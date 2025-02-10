using FluentValidation;

using ToDo.Core;

namespace ToDo.Application
{
    public class UserQuizValidator : AbstractValidator<UserQuizUpsertDto>
    {
        public UserQuizValidator()
        {
            RuleFor(c => c.QuizId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Percentage).NotNull().WithErrorCode(ErrorCodes.NotNull);

        }
    }
}
